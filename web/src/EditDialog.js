import React from 'react';

const fs = require('fs');

// const IMPORT_LOCATION = './../../map.w3x/war3mapImported';
// const itemIcons = fs.readdirSync(IMPORT_LOCATION);

// {"1":{"name":"Item Name Perma","icon":"war3mapImported\\BTNWolf.blp","usable":[],"type":"Helmet","requiredLevel":"15","itemLevel":"27","rarity":"Rare","cost":12,"stats":{"Attack Damage":3}}}

// const existingItems = JSON.parse(fs.readFileSync(ITEMS_JSON_LOCATION, {
//   encoding: 'utf8'
// }));


const ItemClassification = {
  EQUIPMENT: 'Equipment',
  CONSUMABLE: 'Consumable',
};

const ItemType = {
  HELMET: 'Helmet',
  NECKLACE: 'Necklace',
  SHOULDERS: 'Shoulders',
  CHEST: 'Chest',
  BACK: 'Back',
  GLOVES: 'Gloves',
  PANTS: 'Pants',
  FEET: 'Feet',
  RING: 'Ring',
  TRINKET: 'Trinket',
  ONE_HAND_WEAPON: '1H Weapon',
  TWO_HAND_WEAPON: '2H Weapon',
  OFF_HAND: 'Off-hand',
};

const Rarity = {
  COMMON: 'Common',
  UNCOMMON: 'Uncommon',
  RARE: 'Rare',
  EPIC: 'Epic',
  LEGENDARY: 'Legendary',
  DIVINE: 'Divine',
};

const Stat = {
  PERCENT_MOVE_SPEED: '% Move Speed',
  PERCENT_SCALE: '% Scale',
  RAW_HIT_POINTS: 'Raw HP',
  HEALTH_REGEN: 'HP Regen',
  ATTACK_DAMAGE_RAW: 'Attack Damage',
  ATTACK_DAMAGE_PCT: '% Attack Damage',
  SPELL_DAMAGE_RAW: 'Spell Damage',
  SPELL_DAMAGE_PCT: '% Spell Damage',
  HEALING_RAW: 'Healing',
  HEALING_PCT: '% Healing',
  INCOMING_ATTACK_DAMAGE_PCT: '% Physical Damage Taken',
  INCOMING_SPELL_DAMAGE_PCT: '% Spell Damage Taken',
  INCOMING_HEALING_PCT: '% Healing Received',
  INCOMING_ATTACK_DAMAGE_RAW: 'Physical Damage Taken',
  INCOMING_SPELL_DAMAGE_RAW: 'Spell Damage Taken',
  INCOMING_HEALING_RAW: 'Healing Received',
  COOLDOWN_REDUCTION_PCT: '% Cooldown Reduction',
  CAST_SPEED_PCT: '% Cast Speed',
  ATTACK_SPEED_PCT: '% Attack Speed',
  CRITICAL_CHANCE_RAW: '% Crit Chance',
  CRITICAL_DAMAGE_RAW: 'Critical Damage',
  CRITICAL_DAMAGE_PCT: '% Critical Damage',
};

const Class = {
  AZORA: 'Azora',
  YUJI: 'Yuji',
  IVANOV: 'Ivanov',
  TARCZA: 'Tarcza',
  STORMFIST: 'Stormfist',
};

// const data: {
//   name: 'Item Name',
//   icon: 'war3mapImported\\BTNWolf.blp',
//   usable: [], // Empty means ALL, otherwise enum or smth
//   type: ItemType.HELMET,
//   requiredLevel: 12,
//   itemLevel: 12,
//   rarity: Rarity.RARE,
//   cost: 12,
//   stats: {
//     [Stat.ATTACK_DAMAGE]: 3,
//   },
// };

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

class EditDialog extends React.Component {
  state = {
    data: this.props.initialData,
  };

  _getSelectForStats(selectedOption, onChanged) {
    const itemStatOptions = Object.values(Stat).map(stat => {
      return <option key={stat} value={stat}>{stat}</option>
    });

    return <select value={selectedOption} onChange={onChanged} >{itemStatOptions}</select>;
  }

  _onSave = () => {
    this.props.onSave(this.state.data, this.props.id);
  };

  _onChangeSimpleValue = (key, event) => {
    const oldData = Object.assign({}, this.state.data);
    oldData[key] = event.target.value;
    this.setState({
      data: oldData,
    });
  };

  _onAddStat = () => {
    const oldData = Object.assign({}, this.state.data);
    const oldStats = oldData.stats ? Object.assign({}, oldData.stats) : {};

    let nextUnusedKey = null;
    for (const key in Stat) {
      if (oldStats[Stat[key]] == null) {
        nextUnusedKey = Stat[key];
        break;
      }
    }

    if (nextUnusedKey) {
      oldStats[nextUnusedKey] = 0;
      oldData.stats = oldStats;
      this.setState({
        data: oldData,
      });
    }
  };

  _onStatChanged = (key, event) => {
    const oldData = Object.assign({}, this.state.data);
    const oldStats = oldData.stats ? Object.assign({}, oldData.stats) : {};
    oldStats[key] = event.target.value;
    oldData.stats = oldStats;
    this.setState({
      data: oldData,
    });
  };

  _onStatKeyChanged = (oldKey, event) => {
    const newKey = event.target.value;
    const oldData = Object.assign({}, this.state.data);
    const oldStats = oldData.stats ? Object.assign({}, oldData.stats) : {};
    oldStats[newKey] = oldStats[oldKey];
    delete oldStats[oldKey];
    oldData.stats = oldStats;
    this.setState({
      data: oldData,
    });
  };

  _onRemoveStat = (key) => {
    const oldData = Object.assign({}, this.state.data);
    const oldStats = oldData.stats ? Object.assign({}, oldData.stats) : {};
    delete oldStats[key]
    oldData.stats = oldStats;
    this.setState({
      data: oldData,
    });
  };

  _onChangeHeroUsable = (hero, event) => {
    const oldData = Object.assign({}, this.state.data);
    const oldUsable = oldData.usable ? [...oldData.usable] : [];

    const isSelected = event.target.checked;

    if (isSelected) {
      oldUsable.push(hero);
    } else {
      removeA(oldUsable, hero);
    }

    oldData.usable = oldUsable;
    this.setState({
      data: oldData,
    });
  };

  render() {
    const classRadios = Object.values(Class).map(cls => {
      const checked = this.state.data.usable && this.state.data.usable.includes(cls);
      return (
        <span key={cls}>
          <input type="checkbox" id={cls} name="classes" value={cls} checked={checked} onChange={this._onChangeHeroUsable.bind(this, cls)} />
          <label htmlFor={cls}>{cls}</label>
        </span>
      );
    });

    const itemClassOptions = Object.values(ItemClassification).map(type => {
      return <option key={type} value={type}>{type}</option>
    });

    const itemTypeOptions = Object.values(ItemType).map(type => {
      return <option key={type} value={type}>{type}</option>
    });

    const itemRarityOptions = Object.values(Rarity).map(rarity => {
      return <option key={rarity} value={rarity}>{rarity}</option>
    });

    const statInfo = this.state.data.stats || {};
    const stats = Object.entries(statInfo).map(entry => {
      const statKey = entry[0];
      const amount = entry[1];
      return (
        <div key={entry[0]}>
          <input type="number" value={amount} onChange={this._onStatChanged.bind(this, statKey)} />
          {this._getSelectForStats(statKey, this._onStatKeyChanged.bind(this, statKey))}
          <button className="destructive" onClick={this._onRemoveStat.bind(this, statKey)}>Remove</button>
        </div>);
    });

    let equipmentOnlyFields = null;
    let consumableOnlyFields = null;
    if (this.state.data.classification === ItemClassification.EQUIPMENT) {
      equipmentOnlyFields = (
        <div>
          <div>
            <label htmlFor="type">Type: </label>
            <select name="type" id="item-type" value={this.state.data.type} onChange={this._onChangeSimpleValue.bind(this, 'type')} >
              <option value="unset">Choose a type</option>
              {itemTypeOptions}
            </select>
          </div>
          <div className="usableBy">
            <span className="usableText">Usable by: </span> {classRadios}
          </div>
          <div>
            <hr />
            <h3>Stats</h3>
            {stats}
            <button onClick={this._onAddStat}>Add a stat</button>
          </div>
        </div>
      );
    } else if (this.state.data.classification === ItemClassification.CONSUMABLE) {
      consumableOnlyFields = (
        <div>
          <div>
            <label htmlFor="stackSize">Stack Size: </label><input name="stackSize" type="number" placeholder="Stack Size" value={this.state.data.stackSize} onChange={this._onChangeSimpleValue.bind(this, 'stackSize')} />
          </div>
          <div>
            <label htmlFor="tooltip">Tooltip: </label><input name="tooltip" type="text" placeholder="Tooltip" value={this.state.data.tooltip} onChange={this._onChangeSimpleValue.bind(this, 'tooltip')} />
          </div>
          <div>
            <label htmlFor="spellKey">Spell Key: </label><input name="spellKey" type="text" placeholder="Spell Key" value={this.state.data.spellKey} onChange={this._onChangeSimpleValue.bind(this, 'spellKey')} />
          </div>
        </div>
      );
    }

    return (
      <div className="editDialog">
        <div>
          <label htmlFor="name">Name: </label>
          <input name="name" type="text" placeholder="Item Name" value={this.state.data.name} onChange={this._onChangeSimpleValue.bind(this, 'name')} />
        </div>
        <div>
          <label htmlFor="rarity">Rarity: </label>
          <select name="rarity" id="item-type" value={this.state.data.rarity} onChange={this._onChangeSimpleValue.bind(this, 'rarity')}>
            <option value="unset">Choose a rarity</option>
            {itemRarityOptions}
          </select>
        </div>
        <div>
          <div>
            <label htmlFor="icon">Icon: </label><input name="icon" type="text" placeholder="Icon" value={this.state.data.icon} onChange={this._onChangeSimpleValue.bind(this, 'icon')} />
          </div>
        </div>
        <div>
          <label htmlFor="requiredLevel">Required Level: </label><input name="requiredLevel" type="number" placeholder="Required Level" value={this.state.data.requiredLevel} onChange={this._onChangeSimpleValue.bind(this, 'requiredLevel')} />
        </div>
        <div>
          <label htmlFor="itemLevel">Item Level: </label><input name="itemLevel" type="number" placeholder="Item Level" value={this.state.data.itemLevel} onChange={this._onChangeSimpleValue.bind(this, 'itemLevel')} />
        </div>
        <div>
          <label htmlFor="cost">Cost: </label><input name="cost" type="number" placeholder="Cost" value={this.state.data.cost} onChange={this._onChangeSimpleValue.bind(this, 'cost')} />
        </div>

        <div>
          <label htmlFor="classification">Type: </label>
          <select name="classification" id="item-type" value={this.state.data.classification} onChange={this._onChangeSimpleValue.bind(this, 'classification')}>
            <option value="unset">Choose a type of item</option>
            {itemClassOptions}
          </select>
        </div>

        {equipmentOnlyFields}
        {consumableOnlyFields}

        <hr />

        <button className="neutral" onClick={this.props.onCancel}>Cancel</button>
        <button onClick={this._onSave}>Save</button>
      </div>
    );
  }
}

export default EditDialog;
