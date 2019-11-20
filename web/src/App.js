import React from 'react';
import './App.css';
import EditDialog from './EditDialog.js';

const fs = require('fs');

// Traverse down until we find map.w3x in the folder
let path = '.';
let depth = 0;
while (depth < 20 && !fs.existsSync(path + 'map.w3x')) {
  path = path + '../';
}

const ITEMS_JSON_LOCATION = path + 'json/items.json';

// {"1":{"name":"Item Name Perma","icon":"war3mapImported\\BTNWolf.blp","usable":[],"type":"Helmet","requiredLevel":"15","itemLevel":"27","rarity":"Rare","cost":12,"stats":{"Attack Damage":3}}}

const existingItems = JSON.parse(fs.readFileSync(ITEMS_JSON_LOCATION, {
  encoding: 'utf8'
}));

class App extends React.Component {
  state = {
    editInfo: null,
    editId: null,
    existingItems: existingItems,
  };

  _onSave = (info, id) => {
    const oldExistingItems = this.state.existingItems;
    if (Object.entries(info).length > 0) {
      if (id != null) {
        oldExistingItems[id] = info;
      } else {
        let highest = 0;
        for (const key in oldExistingItems) {
          if (Number(key) > highest) {
            highest = key;
          }
        }
        oldExistingItems[Number(highest) + 1] = info;
      }
    }
    this.setState({
      editInfo: null,
      editId: null,
      existingItems: oldExistingItems,
    });

    // Save to filesystem
    fs.writeFileSync(ITEMS_JSON_LOCATION, JSON.stringify(oldExistingItems, null, 2));
  };

  _onCancel = (info, id) => {
    this.setState({
      editInfo: null,
      editId: null,
    });
  };

  _onEditItem(info, id) {
    this.setState({
      editInfo: info,
      editId: id,
    });
  }

  _onNewItem = () => {
    this.setState({
      editInfo: {},
      editId: null,
    });
  };

  render() {
    let editDialog = null;
    let existingItemList = null;
    let addItemButton = null;
    if (this.state.editInfo) {
      editDialog = <EditDialog initialData={this.state.editInfo} id={this.state.editId} onSave={this._onSave} onCancel={this._onCancel} />
    } else {
      existingItemList = Object.entries(this.state.existingItems).map(itemInfo => {
        return <div onClick={this._onEditItem.bind(this, itemInfo[1], itemInfo[0])} key={itemInfo[0]}>{itemInfo[1].name}</div>;
      });
      addItemButton = <button onClick={this._onNewItem}>Add new item</button>;
    }

    return (
      <div className="app">
        {existingItemList}
        {addItemButton}
        {editDialog}
      </div>
    );
  }
}

export default App;
