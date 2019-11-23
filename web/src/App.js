import React from 'react';
import './App.css';
import EditDialog from './EditDialog.js';
import EditQuestDialog from './EditQuestDialog.js';
import EditDropDialog from './EditDropDialog.js';

const fs = require('fs');

// Traverse down until we find map.w3x in the folder
let path = '.';
let depth = 0;
while (depth < 20 && !fs.existsSync(path + 'map.w3x')) {
  path = path + '../';
}

const ITEMS_JSON_LOCATION = path + 'json/items.json';
const QUESTS_JSON_LOCATION = path + 'json/quests.json';
const DROPS_JSON_LOCATION = path + 'json/drops.json';

const existingItems = JSON.parse(fs.readFileSync(ITEMS_JSON_LOCATION, {
  encoding: 'utf8'
}));
const existingQuests = JSON.parse(fs.readFileSync(QUESTS_JSON_LOCATION, {
  encoding: 'utf8'
}));
const existingDrops = JSON.parse(fs.readFileSync(DROPS_JSON_LOCATION, {
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

    editDropInfo: null,
    editDropId: null,
    existingDrops: existingDrops,
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
  };

  _onSaveDrop = (info, id) => {
    const oldExistingDrops = this.state.existingDrops;
    if (Object.entries(info).length > 0) {
      oldExistingDrops[id] = info;
    }
    if (id !== this.state.editDropId && this.state.editDropId !== null) {
      // We changed the ID, delete the old one
      delete oldExistingDrops[this.state.editDropId];
    }
    this.setState({
      editDropInfo: null,
      editDropId: null,
      existingDrops: oldExistingDrops,
    });

    // Save to filesystem
    fs.writeFileSync(DROPS_JSON_LOCATION, JSON.stringify(oldExistingDrops, null, 2));
  };

  _onCancel = (info, id) => {
    this.setState({
      editInfo: null,
      editId: null,

      editQuestInfo: null,
      editQuestId: null,

      editDropInfo: null,
      editDropId: null,
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
      editQuestInfo: {objectives: []},
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

  _onEditDrop = (info, id) => {
    this.setState({
      editDropInfo: info,
      editDropId: id,
    });
  };

  _onNewDrop = () => {
    this.setState({
      editDropInfo: {},
      editDropId: null,
    });
  };

  render() {
    let editItemDialog = null;
    let editQuestDialog = null;
    let editDropDialog = null;
    if (this.state.editInfo) {
      editItemDialog = <EditDialog initialData={this.state.editInfo} id={this.state.editId} onSave={this._onSaveItem} onCancel={this._onCancel} />
    } else if (this.state.editQuestInfo) {
      editQuestDialog = <EditQuestDialog initialData={this.state.editQuestInfo} id={this.state.editQuestId} onSave={this._onSaveQuest} onCancel={this._onCancel} existingItems={this.state.existingItems} existingQuests={this.state.existingQuests} />
    } else if (this.state.editDropInfo) {
      editDropDialog = <EditDropDialog initialData={this.state.editDropInfo} id={this.state.editDropId} onSave={this._onSaveDrop} onCancel={this._onCancel} existingItems={this.state.existingItems} existingQuests={this.state.existingQuests} />
    }

    const existingItemList = Object.entries(this.state.existingItems).map(itemInfo => {
      const cls = itemInfo[1].classification === 'Equipment' ? itemInfo[1].type : itemInfo[1].classification;
      return <div onClick={this._onEditItem.bind(this, itemInfo[1], itemInfo[0])} key={itemInfo[0]}><strong>{itemInfo[1].name}</strong><span className={itemInfo[1].rarity}>{itemInfo[1].rarity}</span><span>{cls}</span></div>;
    });
    const addItemButton = <button onClick={this._onNewItem}>Add new item</button>;

    const existingQuestList = Object.entries(this.state.existingQuests).map(questInfo => {
      return <div onClick={this._onEditQuest.bind(this, questInfo[1], questInfo[0])} key={questInfo[0]}>{questInfo[1].name}</div>;
    });
    const addQuestButton = <button onClick={this._onNewQuest}>Add new quest</button>;

    const existingDropTable = Object.entries(this.state.existingDrops).map(dropInfo => {
      const dropRows = Object.entries(dropInfo[1]).map(entry => {
        const existingItem = this.state.existingItems[entry[0]]
        return (
          <div className="dropTableRow">
            <span>{existingItem ? existingItem.name : entry[0]}: </span>
            <span>{entry[1]}</span>
          </div>
        );
      });
      return (
        <div onClick={this._onEditDrop.bind(this, dropInfo[1], dropInfo[0])} key={dropInfo[0]}>
          {dropInfo[0]}
          {dropRows}
        </div>
      );
    });
    const addDropTableButton = <button onClick={this._onNewDrop}>Add new droptable</button>;

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
    } else if (this.state.tab === 'quests') {
      contents = (
        <div>
          <div className="app">
            {existingQuestList}
            {addQuestButton}
          </div>
          {editQuestDialog}
        </div>
      );
    } else {
      contents = (
        <div>
          <div className="app">
            {existingDropTable}
            {addDropTableButton}
          </div>
          {editDropDialog}
        </div>
      );
    }

    let tint = null
    if (editDropDialog || editQuestDialog || editItemDialog) {
      tint = <div onClick={this._onCancel} className="tint" />;
    }

    return (
      <div>
        <div className="tabs">
          <button onClick={this._switchTab.bind(this, 'items')}>Items</button>
          <button onClick={this._switchTab.bind(this, 'quests')}>Quests</button>
          <button onClick={this._switchTab.bind(this, 'drops')}>Drops</button>
        </div>
        {contents}
        {tint}
      </div>
    );
  }
}

export default App;
