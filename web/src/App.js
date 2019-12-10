import React from "react";
import "./App.css";
import EditDialog from "./EditDialog.js";
import EditQuestDialog from "./EditQuestDialog.js";
import EditDropDialog from "./EditDropDialog.js";
import EditVendorDialog from "./EditVendorDialog.js";

const itemValidator = require("../../compile/validation.js").validateItem;
const questValidator = require("../../compile/validation.js").validateQuest;

const fs = require("fs");

// Traverse down until we find map.w3x in the folder
let path = ".";
let depth = 0;
while (depth < 20 && !fs.existsSync(path + "map.w3x")) {
  path = path + "../";
}

const ITEMS_JSON_LOCATION = path + "json/items.json";
const QUESTS_JSON_LOCATION = path + "json/quests.json";
const DROPS_JSON_LOCATION = path + "json/drops.json";
const VENDORS_JSON_LOCATION = path + "json/vendors.json";

const existingItems = JSON.parse(
  fs.readFileSync(ITEMS_JSON_LOCATION, {
    encoding: "utf8"
  })
);
const existingQuests = JSON.parse(
  fs.readFileSync(QUESTS_JSON_LOCATION, {
    encoding: "utf8"
  })
);
const existingDrops = JSON.parse(
  fs.readFileSync(DROPS_JSON_LOCATION, {
    encoding: "utf8"
  })
);
const existingVendors = JSON.parse(
  fs.readFileSync(VENDORS_JSON_LOCATION, {
    encoding: "utf8"
  })
);

const ItemClassification = {
  EQUIPMENT: "Equipment",
  CONSUMABLE: "Consumable",
  QUEST_ITEM: "Quest Item",
  TRASH: "Trash",
  CRAFTING: "Crafting Material"
};

const ItemType = {
  HELMET: "Helmet",
  NECKLACE: "Necklace",
  SHOULDERS: "Shoulders",
  CHEST: "Chest",
  BACK: "Back",
  GLOVES: "Gloves",
  PANTS: "Pants",
  FEET: "Feet",
  RING: "Ring",
  TRINKET: "Trinket",
  ONE_HAND_WEAPON: "1H Weapon",
  TWO_HAND_WEAPON: "2H Weapon",
  OFF_HAND: "Off-hand"
};

const Rarity = {
  COMMON: "Common",
  UNCOMMON: "Uncommon",
  RARE: "Rare",
  EPIC: "Epic",
  LEGENDARY: "Legendary",
  DIVINE: "Divine"
};

const Stat = {
  PERCENT_MOVE_SPEED: "% Move Speed",
  PERCENT_SCALE: "% Scale",
  RAW_HIT_POINTS: "Raw HP",
  HEALTH_REGEN: "HP Regen",
  ATTACK_DAMAGE_RAW: "Attack Damage",
  ATTACK_DAMAGE_PCT: "% Attack Damage",
  SPELL_DAMAGE_RAW: "Spell Damage",
  SPELL_DAMAGE_PCT: "% Spell Damage",
  HEALING_RAW: "Healing",
  HEALING_PCT: "% Healing",
  INCOMING_ATTACK_DAMAGE_PCT: "% Physical Damage Taken",
  INCOMING_SPELL_DAMAGE_PCT: "% Spell Damage Taken",
  INCOMING_HEALING_PCT: "% Healing Received",
  INCOMING_ATTACK_DAMAGE_RAW: "Physical Damage Taken",
  INCOMING_SPELL_DAMAGE_RAW: "Spell Damage Taken",
  INCOMING_HEALING_RAW: "Healing Received",
  COOLDOWN_REDUCTION_PCT: "% Cooldown Reduction",
  CAST_SPEED_PCT: "% Cast Speed",
  ATTACK_SPEED_PCT: "% Attack Speed",
  CRITICAL_CHANCE_RAW: "% Crit Chance",
  CRITICAL_DAMAGE_RAW: "Critical Damage",
  CRITICAL_DAMAGE_PCT: "% Critical Damage"
};

const Class = {
  AZORA: "Azora",
  YUJI: "Yuji",
  IVANOV: "Ivanov",
  TARCZA: "Tarcza",
  STORMFIST: "Stormfist"
};

class App extends React.Component {
  _searchRef = React.createRef();

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

    editVendorInfo: null,
    editVendorId: null,
    existingVendors: existingVendors,

    itemNameFilter: null,
    itemTypeFilter: null,
    itemSlotFilter: null,
    itemRarityFilter: null,
    itemLevelGTFilter: null,
    itemLevelLTFilter: null
  };

  _onSaveItem = (info, id) => {
    const validity = itemValidator(info);
    if (validity !== true) {
      // Show warning dialog but still save and stuff
      alert(
        "WARNING: " + validity + ", this item will be ignored when building!"
      );
    }

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
      existingItems: oldExistingItems
    });

    // Save to filesystem
    fs.writeFileSync(
      ITEMS_JSON_LOCATION,
      JSON.stringify(oldExistingItems, null, 2)
    );
  };

  _onSaveQuest = (info, id) => {
    const validity = questValidator(info);
    if (validity !== true) {
      // Show warning dialog but still save and stuff
      alert(
        "WARNING: " + validity + ", this quest will be ignored when building!"
      );
    }
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
      existingQuests: oldExistingQuests
    });

    // Save to filesystem
    fs.writeFileSync(
      QUESTS_JSON_LOCATION,
      JSON.stringify(oldExistingQuests, null, 2)
    );
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
      existingDrops: oldExistingDrops
    });

    // Save to filesystem
    fs.writeFileSync(
      DROPS_JSON_LOCATION,
      JSON.stringify(oldExistingDrops, null, 2)
    );
  };

  _onSaveVendor = (info, id) => {
    const oldExistingVendors = this.state.existingVendors;
    if (info.length > 0) {
      oldExistingVendors[id] = info;
    }
    if (id !== this.state.editDropId && this.state.editDropId !== null) {
      // We changed the ID, delete the old one
      delete oldExistingVendors[this.state.editDropId];
    }
    this.setState({
      editVendorInfo: null,
      editVendorId: null,
      existingVendors: oldExistingVendors
    });

    // Save to filesystem
    fs.writeFileSync(
      VENDORS_JSON_LOCATION,
      JSON.stringify(oldExistingVendors, null, 2)
    );
  };

  _onCancel = (info, id) => {
    this.setState({
      editInfo: null,
      editId: null,

      editQuestInfo: null,
      editQuestId: null,

      editDropInfo: null,
      editDropId: null,

      editVendorInfo: null,
      editVendorId: null
    });
  };

  _onEditItem(info, id) {
    this.setState({
      editInfo: info,
      editId: id
    });
  }

  _onNewItem = () => {
    this.setState({
      editInfo: {},
      editId: null
    });
  };

  _onNewQuest = () => {
    this.setState({
      editQuestInfo: { objectives: [] },
      editQuestId: null
    });
  };

  _onEditQuest = (info, id) => {
    this.setState({
      editQuestInfo: info,
      editQuestId: id
    });
  };

  _switchTab = newTab => {
    this.setState({
      tab: newTab
    });
  };

  _onEditDrop = (info, id) => {
    this.setState({
      editDropInfo: info,
      editDropId: id
    });
  };

  _onNewDrop = () => {
    this.setState({
      editDropInfo: {},
      editDropId: null
    });
  };

  _onEditVendor = (info, id) => {
    this.setState({
      editVendorInfo: info,
      editVendorId: id
    });
  };

  _onNewVendor = () => {
    this.setState({
      editVendorInfo: [],
      editVendorId: null
    });
  };

  _onChangeFilter = (filterStr, event) => {
    this.setState({
      [filterStr]: event.target.value
    });
  };

  componentDidMount = () => {
    window.onkeydown = e => {
      if (e.keyCode == 70 && e.ctrlKey) {
        console.log("ctrl f", this);
        this._searchRef.current.focus();
      }
    };
  };

  componentWillUnmount = () => {
    window.onkeydown = null;
  };

  render() {
    let editItemDialog = null;
    let editQuestDialog = null;
    let editDropDialog = null;
    let editVendorDialog = null;
    if (this.state.editInfo) {
      editItemDialog = (
        <EditDialog
          initialData={this.state.editInfo}
          id={this.state.editId}
          onSave={this._onSaveItem}
          onCancel={this._onCancel}
        />
      );
    } else if (this.state.editQuestInfo) {
      editQuestDialog = (
        <EditQuestDialog
          initialData={this.state.editQuestInfo}
          id={this.state.editQuestId}
          onSave={this._onSaveQuest}
          onCancel={this._onCancel}
          existingItems={this.state.existingItems}
          existingQuests={this.state.existingQuests}
          existingDrops={this.state.existingDrops}
          existingVendors={this.state.existingVendors}
        />
      );
    } else if (this.state.editDropInfo) {
      editDropDialog = (
        <EditDropDialog
          initialData={this.state.editDropInfo}
          id={this.state.editDropId}
          onSave={this._onSaveDrop}
          onCancel={this._onCancel}
          existingItems={this.state.existingItems}
          existingQuests={this.state.existingQuests}
          existingDrops={this.state.existingDrops}
          existingVendors={this.state.existingVendors}
        />
      );
    } else if (this.state.editVendorInfo) {
      editVendorDialog = (
        <EditVendorDialog
          initialData={this.state.editVendorInfo}
          id={this.state.editVendorId}
          onSave={this._onSaveVendor}
          onCancel={this._onCancel}
          existingItems={this.state.existingItems}
          existingQuests={this.state.existingQuests}
          existingDrops={this.state.existingDrops}
          existingVendors={this.state.existingVendors}
        />
      );
    }

    const existingItemList = Object.entries(this.state.existingItems)
      .filter(itemInfo => {
        const nameFilter = this.state.itemNameFilter;
        const typeFilter = this.state.itemTypeFilter;
        const slotFilter = this.state.itemSlotFilter;
        const rarityFilter = this.state.itemRarityFilter;
        const itemLevelGTFilter = this.state.itemLevelGTFilter;
        const itemLevelLTFilter = this.state.itemLevelLTFilter;

        if (
          nameFilter != null &&
          nameFilter != "" &&
          itemInfo[1].name != null &&
          !itemInfo[1].name.toLowerCase().includes(nameFilter.toLowerCase())
        ) {
          return false;
        }

        if (
          typeFilter != null &&
          typeFilter !== "all" &&
          itemInfo[1].classification !== typeFilter
        ) {
          return false;
        }
        if (
          slotFilter != null &&
          slotFilter !== "all" &&
          itemInfo[1].type !== slotFilter
        ) {
          return false;
        }
        if (
          rarityFilter != null &&
          rarityFilter !== "all" &&
          itemInfo[1].rarity !== rarityFilter
        ) {
          return false;
        }

        if (
          itemLevelGTFilter != null &&
          itemLevelGTFilter !== "" &&
          itemInfo[1].requiredLevel < itemLevelGTFilter
        ) {
          return false;
        }

        if (
          itemLevelLTFilter != null &&
          itemLevelLTFilter !== "" &&
          itemInfo[1].requiredLevel > itemLevelLTFilter
        ) {
          return false;
        }

        return true;
      })
      .map(itemInfo => {
        const validity = itemValidator(itemInfo[1]);
        const cls =
          itemInfo[1].classification === "Equipment"
            ? itemInfo[1].type
            : itemInfo[1].classification;
        return (
          <div
            className={validity !== true ? "invalid" : "valid"}
            onClick={this._onEditItem.bind(this, itemInfo[1], itemInfo[0])}
            key={itemInfo[0]}
          >
            <strong>{itemInfo[1].name}</strong>
            <span className={itemInfo[1].rarity}>{itemInfo[1].rarity}</span>
            <span>{cls}</span>
            <span>{validity !== true ? "(" + validity + "!)" : null}</span>
          </div>
        );
      });
    const addItemButton = (
      <button onClick={this._onNewItem}>Add new item</button>
    );

    const itemClassOptions = Object.values(ItemClassification).map(type => {
      return (
        <option key={type} value={type}>
          {type}
        </option>
      );
    });

    const itemTypeOptions = Object.values(ItemType).map(type => {
      return (
        <option key={type} value={type}>
          {type}
        </option>
      );
    });

    const itemRarityOptions = Object.values(Rarity).map(rarity => {
      return (
        <option key={rarity} value={rarity}>
          {rarity}
        </option>
      );
    });

    const filters = (
      <div className="filters">
        <input
          ref={this._searchRef}
          placeholder="Filter by name"
          type="text"
          value={this.state.itemNameFilter}
          onChange={this._onChangeFilter.bind(this, "itemNameFilter")}
        />
        <select
          onChange={this._onChangeFilter.bind(this, "itemTypeFilter")}
          value={this.state.itemTypeFilter}
        >
          <option value="all">All Types</option>
          {itemClassOptions}
        </select>
        <select
          onChange={this._onChangeFilter.bind(this, "itemSlotFilter")}
          value={this.state.itemSlotFilter}
        >
          <option value="all">All Slots</option>
          {itemTypeOptions}
        </select>
        <select
          onChange={this._onChangeFilter.bind(this, "itemRarityFilter")}
          value={this.state.itemRarityFilter}
        >
          <option value="all">All Rarities</option>
          {itemRarityOptions}
        </select>
        <input
          placeholder="Required Level >="
          type="text"
          value={this.state.itemLevelGTFilter}
          onChange={this._onChangeFilter.bind(this, "itemLevelGTFilter")}
        />
        <input
          placeholder="Required Level <="
          type="text"
          value={this.state.itemLevelLTFilter}
          onChange={this._onChangeFilter.bind(this, "itemLevelLTFilter")}
        />
      </div>
    );

    const questFilters = (
      <div className="filters">
        <input
          ref={this._searchRef}
          placeholder="Filter by name"
          type="text"
          value={this.state.questNameFilter}
          onChange={this._onChangeFilter.bind(this, "questNameFilter")}
        />
      </div>
    );

    const existingQuestList = Object.entries(this.state.existingQuests).filter(questInfo => {
      const nameFilter = this.state.questNameFilter;

      if (
        nameFilter != null &&
        nameFilter != "" &&
        questInfo[1].name != null &&
        !questInfo[1].name.toLowerCase().includes(nameFilter.toLowerCase())
      ) {
        return false;
      }

      return true;
    }).map(
      questInfo => {
        const validity = questValidator(questInfo[1]);
        return (
          <div
            className={validity !== true ? "invalid" : "valid"}
            onClick={this._onEditQuest.bind(this, questInfo[1], questInfo[0])}
            key={questInfo[0]}
          >
            <strong>{questInfo[1].name}</strong>
            <span>{validity !== true ? "(" + validity + "!)" : null}</span>
          </div>
        );
      }
    );
    const addQuestButton = (
      <button onClick={this._onNewQuest}>Add new quest</button>
    );

    const existingDropTable = Object.entries(this.state.existingDrops).map(
      dropInfo => {
        const dropRows = Object.entries(dropInfo[1]).map(entry => {
          const existingItem = this.state.existingItems[entry[0]];
          return (
            <div className="dropTableRow">
              <span>{existingItem ? existingItem.name : entry[0]}: </span>
              <span>{entry[1]}</span>
            </div>
          );
        });
        return (
          <div
            onClick={this._onEditDrop.bind(this, dropInfo[1], dropInfo[0])}
            key={dropInfo[0]}
          >
            {dropInfo[0]}
            {dropRows}
          </div>
        );
      }
    );
    const addDropTableButton = (
      <button onClick={this._onNewDrop}>Add new droptable</button>
    );

    const existingVendors = Object.entries(this.state.existingVendors).map(
      vendorInfo => {
        const dropRows = vendorInfo[1].map(itemId => {
          const existingItem = this.state.existingItems[itemId];
          return (
            <div className="dropTableRow">
              <span>{existingItem ? existingItem.name : itemId}</span>
            </div>
          );
        });
        return (
          <div
            onClick={this._onEditVendor.bind(
              this,
              vendorInfo[1],
              vendorInfo[0]
            )}
            key={vendorInfo[0]}
          >
            {vendorInfo[0]}
            {dropRows}
          </div>
        );
      }
    );
    const addVendorButton = (
      <button onClick={this._onNewVendor}>Add new vendor</button>
    );

    let contents = null;

    if (this.state.tab === "items") {
      contents = (
        <div>
          <div className="app items">
            {filters}
            {existingItemList}
            {addItemButton}
          </div>
          {editItemDialog}
        </div>
      );
    } else if (this.state.tab === "quests") {
      contents = (
        <div>
          <div className="app quests">
            {questFilters}
            {existingQuestList}
            {addQuestButton}
          </div>
          {editQuestDialog}
        </div>
      );
    } else if (this.state.tab === "drops") {
      contents = (
        <div>
          <div className="app">
            {existingDropTable}
            {addDropTableButton}
          </div>
          {editDropDialog}
        </div>
      );
    } else {
      contents = (
        <div>
          <div className="app">
            {existingVendors}
            {addVendorButton}
          </div>
          {editVendorDialog}
        </div>
      );
    }

    let tint = null;
    if (
      editDropDialog ||
      editQuestDialog ||
      editItemDialog ||
      editVendorDialog
    ) {
      tint = <div onClick={this._onCancel} className="tint" />;
    }

    return (
      <div>
        <div className="tabs">
          <button onClick={this._switchTab.bind(this, "items")}>Items</button>
          <button onClick={this._switchTab.bind(this, "quests")}>Quests</button>
          <button onClick={this._switchTab.bind(this, "drops")}>Drops</button>
          <button onClick={this._switchTab.bind(this, "vendors")}>
            Vendors
          </button>
        </div>
        {contents}
        {tint}
      </div>
    );
  }
}

export default App;
