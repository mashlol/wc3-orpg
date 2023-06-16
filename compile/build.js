// // Compiles the final lua file

const luamin = require("luamin");
const fs = require("fs").promises;
const path = require("path");
const { glob } = require("glob");

console.log("build args: ", process.argv);
const skipMin = process.argv[2] == "--no-min";

async function wrapModule(modulePath) {
  const data = await fs.readFile(modulePath, { encoding: "utf-8" });

  const srcRelativePath = path.relative(".", modulePath).replace(/^gen/, "src");
  const moduleName = srcRelativePath.replace(/[\\.]/g, "_");

  const wrappedData =
    "local " + moduleName + " = function()\n\n" + data + "\nend\n\n";
  const buildPath = "./bin/" + moduleName + ".lua";

  await fs.writeFile(buildPath, wrappedData);

  return [srcRelativePath, moduleName, wrappedData];
}

// 1. Recursively find all lua files in ./src and ./gen
// 2. Read the contents of each file, wrap it in a lua function, write it to an output dir
// 3. Build the require map based on the wrapped function names
// 4. Wrap the entire thing in another lua function called `Main`.
// 5. Optionally minify the result.
// 6. Write it all to an output file (./bin/war3map_compiled.lua)
async function build() {
  const headerContentsHandle = fs.readFile("./compile/header._lua", {
    encoding: "utf-8",
  });
  const internalContentsHandle = fs.readFile("./compile/internal._lua", {
    encoding: "utf-8",
  });

  const srcFilesGlob = glob("src/**/*.lua");
  const genFilesGlob = glob("gen/**/*.lua");

  const srcFiles = await srcFilesGlob;
  const genFiles = await genFilesGlob;

  const allFiles = srcFiles.concat(genFiles);

  const results = await Promise.all(allFiles.map((file) => wrapModule(file)));

  const modules = {};
  results.forEach((result) => {
    modules[result[0]] = result[1];
  });

  const internalContents = await internalContentsHandle;

  const allModulesSource = results
    .map((result) => result[2])
    .concat([internalContents])
    .join("\n");

  const headerContents = await headerContentsHandle;

  let compiledSource = headerContents + "\n\nfunction MapMain()\n";
  if (skipMin) {
    compiledSource += "__DEBUG__ = true\n";
  }
  for (let k in modules) {
    compiledSource +=
      "requireMap['" + k.replace(/\\/g, "/") + "'] = " + modules[k] + "\n";
  }

  compiledSource += "\n\n" + allModulesSource + "\n\n";

  if (skipMin) {
    compiledSource +=
      "TimerStart(CreateTimer(), 0.0, false, function() local status, err = pcall(function() require('src/main.lua') end) print(status, err) end)\n\n";
  } else {
    compiledSource += "require('src/main.lua')\n\n";
  }

  compiledSource += "end\n";

  if (!skipMin) {
    compiledSource = luamin.minify(compiledSource);
  }

  await fs.writeFile("./bin/war3map_compiled.lua", compiledSource);
}

build();
