import React from 'react';

const fs = require('fs');

let path = '.';
let depth = 0;
while (depth < 20 && !fs.existsSync(path + 'map.w3x')) {
  path = path + '../';
}

const LUA_PATH_LOCATION = path + 'map.w3x/war3map.lua';

function removeA(arr) {
    var what, a = arguments, L = a.length, ax;
    while (L > 1 && arr.length) {
        what = a[--L];
        while ((ax= arr.indexOf(what)) !== -1) {
            arr.splice(ax, 1);
        }
    }
    return arr;
}

class EditVendorDialog extends React.Component {
  state = {
    data: this.props.initialData,
    id: this.props.id,
  };

  _onSave = () => {
    this.props.onSave(this.state.data, this.state.id);
  };

  _addNewItem = () => {
    const oldData = [...this.state.data];
    oldData.push("1");
    this.setState({
      data: oldData,
    });
  };

  _onItemChanged = (oldKey, event) => {
    const oldData = [...this.state.data];
    oldData[oldKey] = event.target.value;
    this.setState({
      data: oldData,
    });
  };

  _onItemRemoved = (key) => {
    console.log('removing elemnt', key, this.state.data);
    const oldData = [...this.state.data];
    console.log(oldData);
    oldData.splice(key, 1);
    console.log(oldData);
    this.setState({
      data: oldData,
    });
  };

  _onChangeUnit = (event) => {
    this.setState({
      id: event.target.value,
    });
  };

  render() {
    const luaContents = fs.readFileSync(LUA_PATH_LOCATION, {encoding: 'utf8'});
    const validUnits = Array.from(new Set(luaContents.match(/gg_unit_[a-zA-Z0-9]{4}_\d{4}/g)));

    const validUnitOptions = validUnits.map(unitId => {
      return <option key={unitId} value={unitId}>{unitId}</option>;
    });

    const validItemOptions = Object.entries(this.props.existingItems).map(entry => {
      const itemId = entry[0];
      const itemName = entry[1].name;
      return <option key={itemId} value={itemId}>{itemName}</option>
    });

    const itemRows = this.state.data.map((val, idx) => {
      return (
        <div className="dropTableRow">
          <select value={val} onChange={this._onItemChanged.bind(this, idx)}>
            <option value="none">None</option>
            {validItemOptions}
          </select>
          <button className="destructive" onClick={this._onItemRemoved.bind(this, idx)}>Remove</button>
        </div>
      );
    });

    return (
      <div className="editDialog">
        <div>
          <select value={this.state.id} onChange={this._onChangeUnit}>
            <option value="unset">Choose a unit to be the vendor</option>
            {validUnitOptions}
          </select>
        </div>
        {itemRows}

        <button onClick={this._addNewItem}>Add new item</button>

        <hr />

        <button className="neutral" onClick={this.props.onCancel}>Cancel</button>
        <button onClick={this._onSave}>Save</button>
      </div>
    );
  }
}

export default EditVendorDialog;
