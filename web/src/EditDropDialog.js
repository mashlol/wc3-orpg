import React from 'react';

const fs = require('fs');

let path = '.';
let depth = 0;
while (depth < 20 && !fs.existsSync(path + 'map.w3x')) {
  path = path + '../';
}

const LUA_PATH_LOCATION = path + 'map.w3x/war3map.lua';

const luaContents = fs.readFileSync(LUA_PATH_LOCATION, {encoding: 'utf8'});
const unitFullMatch = luaContents.match(/BlzCreateUnitWithSkin\(p, FourCC\(\"([a-zA-Z0-9]{4})\"\)/g);
const unitIds = unitFullMatch.map(x => {
  return x.substring(33, 37);
});
const validUnitIds = Array.from(new Set(unitIds));

class EditDropDialog extends React.Component {
  state = {
    data: this.props.initialData,
    id: this.props.id,
  };

  _onSave = () => {
    this.props.onSave(this.state.data, this.state.id);
  };

  _addNewDrop = () => {
    const oldData = Object.assign({}, this.state.data);

    let nextUnusedKey = null;
    for (const key in this.props.existingItems) {
      console.log('checking if key is used', key);
      if (oldData[key] == null) {
        nextUnusedKey = key;
        break;
      }
    }

    if (nextUnusedKey) {
      oldData[nextUnusedKey] = 0;
      this.setState({
        data: oldData,
      });
    }
  };

  _onDropChange = (key, event) => {
    const oldData = Object.assign({}, this.state.data);
    oldData[key] = event.target.value;
    this.setState({
      data: oldData,
    });
  };

  _onDropKeyChanged = (oldKey, event) => {
    const newKey = event.target.value;
    const oldData = Object.assign({}, this.state.data);
    oldData[newKey] = oldData[oldKey];
    delete oldData[oldKey];
    this.setState({
      data: oldData,
    });
  };

  _onDropRemoved = (key) => {
    const oldData = Object.assign({}, this.state.data);
    delete oldData[key];
    this.setState({
      data: oldData,
    });
  };

  _onChangeUnitId = (event) => {
    this.setState({
      id: event.target.value,
    });
  };

  render() {
    const validUnitOptions = validUnitIds.map(unitId => {
      return <option key={unitId} value={unitId}>{unitId}</option>;
    });

    const validItemOptions = Object.entries(this.props.existingItems).map(entry => {
      const itemId = entry[0];
      const itemName = entry[1].name;
      return <option key={itemId} value={itemId}>{itemName}</option>
    });

    let totalWeight = 0;
    Object.entries(this.state.data).forEach(entry => {
      totalWeight += Number(entry[1]);
    });

    const dropRows = Object.entries(this.state.data).map(entry => {
      return (
        <div className="dropTableRow">
          <select value={entry[0]} onChange={this._onDropKeyChanged.bind(this, entry[0])}>
            <option value="none">None</option>
            {validItemOptions}
          </select>
          <input type="number" value={entry[1]} onChange={this._onDropChange.bind(this, entry[0])} />
          <span className="pct">{(Number(entry[1]) / totalWeight * 100).toFixed(2)} %</span>
          <button className="destructive" onClick={this._onDropRemoved.bind(this, entry[0])}>Remove</button>
        </div>
      );
    });

    return (
      <div className="editDialog">
        <div>
          <select value={this.state.id} onChange={this._onChangeUnitId}>
            <option value="unset">Choose a unit id</option>
            {validUnitOptions}
          </select>
        </div>
        {dropRows}

        <button onClick={this._addNewDrop}>Add new drop</button>

        <hr />

        <button className="neutral" onClick={this.props.onCancel}>Cancel</button>
        <button onClick={this._onSave}>Save</button>
      </div>
    );
  }
}

export default EditDropDialog;
