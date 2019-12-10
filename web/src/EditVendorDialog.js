import React from "react";
import SelectSearch from "react-select-search";

const fs = require("fs");

let path = ".";
let depth = 0;
while (depth < 20 && !fs.existsSync(path + "map.w3x")) {
  path = path + "../";
}

const LUA_PATH_LOCATION = path + "map.w3x/war3map.lua";

function removeA(arr) {
  var what,
    a = arguments,
    L = a.length,
    ax;
  while (L > 1 && arr.length) {
    what = a[--L];
    while ((ax = arr.indexOf(what)) !== -1) {
      arr.splice(ax, 1);
    }
  }
  return arr;
}

class EditVendorDialog extends React.Component {
  state = {
    data: this.props.initialData,
    id: this.props.id
  };

  _onSave = () => {
    this.props.onSave(this.state.data, this.state.id);
  };

  _addNewItem = () => {
    const oldData = [...this.state.data];
    oldData.push("1");
    this.setState({
      data: oldData
    });
  };

  _onItemChanged = (oldKey, event) => {
    const oldData = [...this.state.data];
    oldData[oldKey] = event.value;
    this.setState({
      data: oldData
    });
  };

  _onItemRemoved = key => {
    const oldData = [...this.state.data];
    oldData.splice(key, 1);
    this.setState({
      data: oldData
    });
  };

  _onChangeUnit = event => {
    this.setState({
      id: event.value
    });
  };

  render() {
    const luaContents = fs.readFileSync(LUA_PATH_LOCATION, {
      encoding: "utf8"
    });
    const validUnits = Array.from(
      new Set(luaContents.match(/gg_unit_[a-zA-Z0-9]{4}_\d{4}/g))
    );

    const validUnitOptions = [...validUnits.sort().filter(unit => {
      return !this.props.existingVendors[unit];
    }).map(unit => {
      return { value: unit, name: unit };
    }), {value: this.state.id, name: this.state.id}];

    const validItemOptions = Object.entries(this.props.existingItems)
      .sort((a, b) => a[1].name.localeCompare(b[1].name))
      .map(entry => {
        const itemId = entry[0];
        const itemName = entry[1].name;
        return { value: itemId, name: itemName };
      });

    const itemRows = this.state.data.map((val, idx) => {
      return (
        <div className="dropTableRow">
          <SelectSearch
            options={validItemOptions}
            value={val}
            onChange={this._onItemChanged.bind(this, idx)}
            placeholder="Choose an item..."
          />
          <button
            className="destructive"
            onClick={this._onItemRemoved.bind(this, idx)}
          >
            Remove
          </button>
        </div>
      );
    });

    return (
      <div className="editDialog">
        <div>
          <SelectSearch
            options={validUnitOptions}
            value={this.state.id === null ? undefined : this.state.id}
            onChange={this._onChangeUnit}
            placeholder="Choose a unit to be the vendor"
          />
        </div>
        {itemRows}

        <button onClick={this._addNewItem}>Add new item</button>

        <hr />

        <button className="neutral" onClick={this.props.onCancel}>
          Cancel
        </button>
        <button onClick={this._onSave}>Save</button>
      </div>
    );
  }
}

export default EditVendorDialog;
