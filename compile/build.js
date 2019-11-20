// // Compiles the final lua file

const luamin = require('luamin');
const fs = require('fs');
const path = require('path');
const concat = require('concat');

console.log('build args: ', process.argv);
var skipMin = process.argv[2] == '--no-min';

var walk = function(dir, done) {
  var results = [];
  fs.readdir(dir, function(err, list) {
    if (err) return done(err);
    var pending = list.length;
    if (!pending) return done(null, results);
    list.forEach(function(file) {
      file = path.resolve(dir, file);
      fs.stat(file, function(err, stat) {
        if (stat && stat.isDirectory()) {
          walk(file, function(err, res) {
            results = results.concat(res);
            if (!--pending) done(null, results);
          });
        } else {
          if (path.extname(file) === '.lua') {
            results.push(file);
          }
          if (!--pending) done(null, results);
        }
      });
    });
  });
};

const filesToConcat = [];
walk('./src', (err, res) => {
  const numFiles = res.length;
  let numIterated = 0;
  const writtenFiles = [];
  const modules = {};
  res.forEach(srcAbsPath => {
    const relativeSrcPath = path.relative('.', srcAbsPath);
    fs.readFile(srcAbsPath, {encoding: 'utf-8'}, (err, data) => {
      if (err) throw err;

      const funcRequireName = relativeSrcPath.replace(/[\\.]/g, '_');
      data = "local " + funcRequireName + " = function()\n\n" + data + "\nend\n\n";

      const buildPath = './bin/' + funcRequireName + '.lua';
      fs.writeFile(buildPath, data, {encoding: 'utf-8', flag: 'w'}, (err) => {
        if (err) throw err;

        numIterated++;

        writtenFiles.push(buildPath);
        modules[relativeSrcPath] = funcRequireName;

        if (numIterated == numFiles) {

          // Concat the files into a single one
          concat(['./compile/header._lua'].concat(writtenFiles), './bin/war3map_compiled.lua').then(() => {
            let requireMap = "\n";
            if (skipMin) {
              requireMap += "__DEBUG__ = true\n";
            }
            for (let k in modules) {
              requireMap += "requireMap['" + k.replace(/\\/g, '/') + "'] = " + modules[k] + "\n";
            }

            requireMap += "\n\n";

            if (skipMin) {
              requireMap += "TimerStart(CreateTimer(), 0.0, false, function() local status, err = pcall(function() require('src/main.lua') end) print(status, err) end)\n\n";
            } else {
              requireMap += "require('src/main.lua')\n\n";
            }

            fs.appendFile('./bin/war3map_compiled.lua', requireMap, {encoding: 'utf-8'}, (err) => {
              if (err) throw err;

              if (!skipMin) {
                console.log("Minifying")
                // Now minify the file
                const contents = fs.readFileSync('./bin/war3map_compiled.lua', {encoding: 'utf-8'});
                fs.writeFileSync('./bin/war3map_compiled.lua', luamin.minify(contents));
              }
            });
          });
        }
      });
    });
  });
});

