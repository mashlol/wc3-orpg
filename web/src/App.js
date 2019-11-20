import React from 'react';
import './App.css';
import EditDialog from './EditDialog.js';
import EditQuestDialog from './EditQuestDialog.js';

const fs = require('fs');

// Traverse down until we find map.w3x in the folder
let path = '.';
let depth = 0;
while (depth < 20 && !fs.existsSync(path + 'map.w3x')) {
  path = path + '../';
}

const ITEMS_JSON_LOCATION = path + 'json/items.json';
const QUESTS_JSON_LOCATION = path + 'json/quests.json';

const existingItems = JSON.parse(fs.readFileSync(ITEMS_JSON_LOCATION, {
  encoding: 'utf8'
}));
const existingQuests = JSON.parse(fs.readFileSync(QUESTS_JSON_LOCATION, {
  encoding: 'utf8'
}));

class App extends React.Component {
  state = {
    tab: "items",

    editInfo: null,
    editId: null,
    existingItems: existingItems,

    editQuestInfo: null,
    editQuestId: null,
    existingQuests: existingQuests,
  };

  _onSaveItem = (info, id) => {
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

  _onSaveQuest = (info, id) => {
    console.log('Quest saved', info, id);
    const oldExistingQuests = this.state.existingQuests;
    if (Object.entries(info).length > 0) {
      if (id != null) {
        oldExistingQuests[id] = info;
      } else {
        let highest = 0;
        for (const key in oldExistingQuests) {
          if (Number(key) > highest) {
            highest = key;
          }
        }
        oldExistingQuests[Number(highest) + 1] = info;
      }
    }
    this.setState({
      editQuestInfo: null,
      editQuestId: null,
      existingQuests: oldExistingQuests,
    });

    // Save to filesystem
    fs.writeFileSync(QUESTS_JSON_LOCATION, JSON.stringify(oldExistingQuests, null, 2));
  }

  _onCancel = (info, id) => {
    this.setState({
      editInfo: null,
      editId: null,

      editQuestInfo: null,
      editQuestId: null,
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

  _onNewQuest = () => {
    this.setState({
      editQuestInfo: {},
      editQuestId: null,
    });
  };

  _onEditQuest = (info, id) => {
    this.setState({
      editQuestInfo: info,
      editQuestId: id,
    });
  };

  _switchTab = (newTab) => {
    this.setState({
      tab: newTab,
    });
  };

  render() {
    let editItemDialog = null;
    let editQuestDialog = null;
    if (this.state.editInfo) {
      editItemDialog = <EditDialog initialData={this.state.editInfo} id={this.state.editId} onSave={this._onSaveItem} onCancel={this._onCancel} />
    } else if (this.state.editQuestInfo) {
      editQuestDialog = <EditQuestDialog initialData={this.state.editQuestInfo} id={this.state.editQuestId} onSave={this._onSaveQuest} onCancel={this._onCancel} existingItems={this.state.existingItems} />
    }

    const existingItemList = Object.entries(this.state.existingItems).map(itemInfo => {
      return <div onClick={this._onEditItem.bind(this, itemInfo[1], itemInfo[0])} key={itemInfo[0]}>{itemInfo[1].name}</div>;
    });
    const addItemButton = <button onClick={this._onNewItem}>Add new item</button>;

    const existingQuestList = Object.entries(this.state.existingQuests).map(questInfo => {
      return <div onClick={this._onEditQuest.bind(this, questInfo[1], questInfo[0])} key={questInfo[0]}>{questInfo[1].name}</div>;
    });
    const addQuestButton = <button onClick={this._onNewQuest}>Add new quest</button>;

    let contents = null;

    if (this.state.tab === 'items') {
      contents = (
        <div>
          <div className="app">
            {existingItemList}
            {addItemButton}
          </div>
          {editItemDialog}
        </div>
      );
    } else {
      contents = (
        <div>
          <div className="app">
            {existingQuestList}
            {addQuestButton}
          </div>
          {editQuestDialog}
        </div>
      );
    }

    return (
      <div>
        <div className="tabs">
          <button onClick={this._switchTab.bind(this, 'items')}>Items</button>
          <button onClick={this._switchTab.bind(this, 'quests')}>Quests</button>
        </div>
        {contents}
      </div>
    );
  }
}

export default App;
