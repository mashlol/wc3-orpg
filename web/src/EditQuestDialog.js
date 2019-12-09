import React from "react";
import SelectSearch from "react-select-search";

const fs = require("fs");

let path = ".";
let depth = 0;
while (depth < 20 && !fs.existsSync(path + "map.w3x")) {
  path = path + "../";
}

const LUA_PATH_LOCATION = path + "map.w3x/war3map.lua";

const ObjectiveType = {
  KILL: "Kill",
  GATHER: "Gather",
  DISCOVER: "Discover"
};

// const data = {
//   "name": "Trouble in Turtle Town",
//   "getQuestFrom": "gg_unit_nvil_0069",
//   "handQuestTo": "gg_unit_nvil_0069",
//   "obtainText": "Yo yo I got a quest for you",
//   "incompleteText": "Yo yo the quest is incomplet yo",
//   "completedText": "Yo yo nice job yo",
//   "rewards": {
//     "exp": 50,
//     "gold": 5,
//     "items": {
//       "6": 5
//     }
//   },
//   "objectives": [
//     {
//       "type": "kill",
//       "amount": 10,
//       "toKill": "hmbs",
//       "name": "Snapping Turtles",
//       "verb": "Exterminate",
//       "verbPast": "exterminated"
//     },
//     {
//       "type": "item",
//       "amount": 10,
//       "itemId": 77
//     }
//   ],
//   "prerequisites": [1, 2],
//   "levelRequirement": 1
// }

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

class EditQuestDialog extends React.Component {
  state = {
    data: this.props.initialData
  };

  _getSelectForObjective(selectedOption, onChanged) {
    const objectiveOptions = Object.values(ObjectiveType).map(type => {
      return (
        <option key={type} value={type}>
          {type}
        </option>
      );
    });

    return (
      <select value={selectedOption} onChange={onChanged}>
        <option value="unset">Choose an objective type</option>
        {objectiveOptions}
      </select>
    );
  }

  _getSelectForPrerequisite(selectedOption, onChanged) {
    const prerequisiteOptions = Object.entries(this.props.existingQuests).map(
      entry => {
        return {value: entry[0], name: entry[1].name};
      }
    );

    return (
      <SelectSearch
        options={prerequisiteOptions}
        value={selectedOption}
        onChange={onChanged}
        placeholder="Choose a quest..."
      />
    );
  }

  _onSave = () => {
    this.props.onSave(this.state.data, this.props.id);
  };

  _onChangeSimpleValue = (key, event) => {
    const oldData = Object.assign({}, this.state.data);
    oldData[key] = event.value || event.target.value;
    this.setState({
      data: oldData
    });
  };

  _onChangeNestedValue = (key, subkey, event) => {
    const oldData = Object.assign({}, this.state.data);
    if (oldData[key] == null) {
      oldData[key] = {};
    }
    oldData[key][subkey] = event.target.value;
    this.setState({
      data: oldData
    });
  };

  _onAddObjective = () => {
    const oldData = Object.assign({}, this.state.data);
    const oldObjectives = oldData.objectives ? [...oldData.objectives] : [];

    oldObjectives.push({});
    oldData.objectives = oldObjectives;
    this.setState({
      data: oldData
    });
  };

  _onObjectiveChanged = (key, field, event) => {
    const oldData = Object.assign({}, this.state.data);
    const oldObjectives = oldData.objectives ? [...oldData.objectives] : [];
    oldObjectives[key][field] = event.value || event.target.value;
    oldData.objectives = oldObjectives;
    this.setState({
      data: oldData
    });
  };

  _onRemoveObjective = key => {
    const oldData = Object.assign({}, this.state.data);
    const oldObjectives = oldData.objectives ? [...oldData.objectives] : [];
    oldObjectives.splice(key, 1);
    oldData.objectives = oldObjectives;
    this.setState({
      data: oldData
    });
  };

  _onAddPrerequisite = () => {
    const oldData = Object.assign({}, this.state.data);
    const oldPrereqs = oldData.prerequisites ? [...oldData.prerequisites] : [];
    oldPrereqs.push("1");
    oldData.prerequisites = oldPrereqs;
    this.setState({
      data: oldData
    });
  };

  _onChangePrerequisite = (key, event) => {
    const oldData = Object.assign({}, this.state.data);
    const oldPrereqs = oldData.prerequisites ? [...oldData.prerequisites] : [];
    oldPrereqs[key] = event.value;
    oldData.prerequisites = oldPrereqs;
    this.setState({
      data: oldData
    });
  };

  _onRemovePrerequisite = key => {
    const oldData = Object.assign({}, this.state.data);
    const oldPrereqs = oldData.prerequisites ? [...oldData.prerequisites] : [];
    oldPrereqs.splice(key, 1);
    oldData.prerequisites = oldPrereqs;
    this.setState({
      data: oldData
    });
  };

  _onAddItemReward = () => {
    const oldData = Object.assign({}, this.state.data);
    const oldItemRewards =
      oldData.rewards && oldData.rewards.items
        ? Object.assign({}, oldData.rewards.items)
        : {};
    oldItemRewards["1"] = 1;
    if (!oldData.rewards) {
      oldData.rewards = {};
    }
    oldData.rewards.items = oldItemRewards;
    this.setState({
      data: oldData
    });
  };

  _onChangeItemRewardAmount = (key, event) => {
    const oldData = Object.assign({}, this.state.data);
    const oldItemRewards =
      oldData.rewards && oldData.rewards.items
        ? Object.assign({}, oldData.rewards.items)
        : {};
    oldItemRewards[key] = event.target.value;
    oldData.rewards.items = oldItemRewards;
    this.setState({
      data: oldData
    });
  };

  _onChangeItemKey = (oldKey, event) => {
    const oldData = Object.assign({}, this.state.data);
    const oldItemRewards =
      oldData.rewards && oldData.rewards.items
        ? Object.assign({}, oldData.rewards.items)
        : {};
    const oldValue = oldItemRewards[oldKey];
    delete oldItemRewards[oldKey];
    oldItemRewards[event.value] = oldValue;
    oldData.rewards.items = oldItemRewards;
    this.setState({
      data: oldData
    });
  };

  _onDeleteItemReward = key => {
    console.log("delete key");
    const oldData = Object.assign({}, this.state.data);
    const oldItemRewards =
      oldData.rewards && oldData.rewards.items
        ? Object.assign({}, oldData.rewards.items)
        : {};
    delete oldItemRewards[key];
    oldData.rewards.items = oldItemRewards;
    this.setState({
      data: oldData
    });
  };

  render() {
    const luaContents = fs.readFileSync(LUA_PATH_LOCATION, {
      encoding: "utf8"
    });

    const validUnits = Array.from(
      new Set(luaContents.match(/gg_unit_[a-zA-Z0-9]{4}_\d{4}/g))
    );
    const validRegions = Array.from(
      new Set(luaContents.match(/gg_rct_[a-zA-Z0-9_]+/g))
    );

    const unitFullMatch = luaContents.match(
      /BlzCreateUnitWithSkin\(p, FourCC\(\"([a-zA-Z0-9]{4})\"\)/g
    );
    const unitIds = unitFullMatch.map(x => {
      return x.substring(33, 37);
    });
    const validUnitIds = Array.from(new Set(unitIds));

    const validUnitOptions = Object.values(validUnits)
      .sort()
      .map(unitGlobal => {
        return {value: unitGlobal, name: unitGlobal};
      });

    const validUnitIdOptions = Object.values(validUnitIds)
      .sort()
      .map(unitId => {
        return {value: unitId, name: unitId};
      });

    const validItemOptions = Object.entries(this.props.existingItems)
      .sort((a, b) => a[1].name.localeCompare(b[1].name))
      .map(entry => {
        const itemId = entry[0];
        const itemName = entry[1].name;
        return { value: itemId, name: itemName };
      });

    const validRegionOptions = Object.values(validRegions).map(regionGlobal => {
      return (
        <option key={regionGlobal} value={regionGlobal}>
          {regionGlobal}
        </option>
      );
    });

    const objectiveInfo = this.state.data.objectives || [];
    const objectives = objectiveInfo.map((entry, idx) => {
      let objectiveSpecificFields = null;
      if (entry.type === ObjectiveType.KILL) {
        objectiveSpecificFields = (
          <span>
            <input
              name="amount"
              type="number"
              placeholder="Amount"
              value={this.state.data.objectives[idx].amount}
              onChange={this._onObjectiveChanged.bind(this, idx, "amount")}
            />
            <SelectSearch
              options={validUnitIdOptions}
              placeholder="Select a unit..."
              value={this.state.data.objectives[idx].toKill}
              onChange={this._onObjectiveChanged.bind(this, idx, "toKill")}
            />
            <input
              name="name"
              type="text"
              placeholder="Name (plural if multiple amount)"
              value={this.state.data.objectives[idx].name}
              onChange={this._onObjectiveChanged.bind(this, idx, "name")}
            />
            <input
              name="verb"
              type="text"
              placeholder="Verb (Optional)"
              value={this.state.data.objectives[idx].verb}
              onChange={this._onObjectiveChanged.bind(this, idx, "verb")}
            />
            <input
              name="verbPast"
              type="text"
              placeholder="Verb Past (Optional)"
              value={this.state.data.objectives[idx].verbPast}
              onChange={this._onObjectiveChanged.bind(this, idx, "verbPast")}
            />
          </span>
        );
      } else if (entry.type === ObjectiveType.GATHER) {
        objectiveSpecificFields = (
          <span>
            <input
              name="amount"
              type="number"
              placeholder="Amount"
              value={this.state.data.objectives[idx].amount}
              onChange={this._onObjectiveChanged.bind(this, idx, "amount")}
            />
            <SelectSearch
              options={validItemOptions}
              value={this.state.data.objectives[idx].itemId}
              onChange={this._onObjectiveChanged.bind(this, idx, "itemId")}
              placeholder="Choose an item..."
            />
          </span>
        );
      } else if (entry.type === ObjectiveType.DISCOVER) {
        objectiveSpecificFields = (
          <span>
            <input
              name="name"
              type="text"
              placeholder="Name"
              value={this.state.data.objectives[idx].name}
              onChange={this._onObjectiveChanged.bind(this, idx, "name")}
            />
            <select
              name="region"
              type="text"
              placeholder="region"
              value={this.state.data.objectives[idx].region}
              onChange={this._onObjectiveChanged.bind(this, idx, "region")}
            >
              <option value="unset">Choose a region</option>
              {validRegionOptions}
            </select>
          </span>
        );
      }

      return (
        <div className="objective" key={idx}>
          {this._getSelectForObjective(
            entry.type,
            this._onObjectiveChanged.bind(this, idx, "type")
          )}

          {objectiveSpecificFields}

          <button
            className="destructive"
            onClick={this._onRemoveObjective.bind(this, idx)}
          >
            Remove
          </button>
        </div>
      );
    });

    const preReqInfo = this.state.data.prerequisites || [];
    const prerequisites = preReqInfo.map((entry, idx) => {
      return (
        <div key={idx}>
          {this._getSelectForPrerequisite(
            entry,
            this._onChangePrerequisite.bind(this, idx)
          )}
          <button
            className="destructive"
            onClick={this._onRemovePrerequisite.bind(this, idx)}
          >
            Remove
          </button>
        </div>
      );
    });

    const itemRewards =
      this.state.data.rewards &&
      this.state.data.rewards.items &&
      Object.entries(this.state.data.rewards.items).map(rewardInfo => {
        return (
          <div className="objective">
            <label>Item Reward:</label>
            <input
              type="text"
              placeholder="Amount"
              value={rewardInfo[1]}
              onChange={this._onChangeItemRewardAmount.bind(
                this,
                rewardInfo[0]
              )}
            />
            <SelectSearch
              options={validItemOptions}
              value={rewardInfo[0]}
              onChange={this._onChangeItemKey.bind(this, rewardInfo[0])}
              placeholder="Choose an item..."
            />
            <button
              className="destructive"
              onClick={this._onDeleteItemReward.bind(this, rewardInfo[0])}
            >
              Remove
            </button>
          </div>
        );
      });

    return (
      <div className="editDialog">
        <div>
          <label htmlFor="questName">Quest Name:</label>
          <input
            name="questName"
            type="text"
            placeholder="Quest Name"
            value={this.state.data.name}
            onChange={this._onChangeSimpleValue.bind(this, "name")}
          />
        </div>
        <div>
          <label htmlFor="getQuestFrom">Receive Quest From:</label>
          <SelectSearch
            options={validUnitOptions}
            name="getQuestFrom"
            value={this.state.data.getQuestFrom}
            onChange={this._onChangeSimpleValue.bind(this, "getQuestFrom")}
          />
        </div>
        <div>
          <label htmlFor="handQuestTo">Hand Quest To:</label>
          <SelectSearch
            options={validUnitOptions}
            name="handQuestTo"
            value={this.state.data.handQuestTo}
            onChange={this._onChangeSimpleValue.bind(this, "handQuestTo")}
          />
        </div>
        <div>
          <label htmlFor="levelRequirement">Required Level: </label>
          <input
            name="levelRequirement"
            type="number"
            placeholder="Required Level"
            value={this.state.data.levelRequirement}
            onChange={this._onChangeSimpleValue.bind(this, "levelRequirement")}
          />
        </div>
        <div>
          <label htmlFor="obtainText">Obtain Text: </label>
          <textarea
            name="obtainText"
            placeholder="Obtain Text"
            value={this.state.data.obtainText}
            onChange={this._onChangeSimpleValue.bind(this, "obtainText")}
          />
        </div>
        <div>
          <label htmlFor="incompleteText">Incomplete Text: </label>
          <textarea
            name="incompleteText"
            placeholder="Incomplete Text"
            value={this.state.data.incompleteText}
            onChange={this._onChangeSimpleValue.bind(this, "incompleteText")}
          />
        </div>
        <div>
          <label htmlFor="completedText">Complete Text: </label>
          <textarea
            name="completedText"
            placeholder="Complete Text"
            value={this.state.data.completedText}
            onChange={this._onChangeSimpleValue.bind(this, "completedText")}
          />
        </div>
        <hr />
        <h3> Rewards</h3>
        <div>
          <label htmlFor="exp">Exp Reward: </label>
          <input
            name="exp"
            type="number"
            placeholder="Exp Reward"
            value={this.state.data.rewards && this.state.data.rewards.exp}
            onChange={this._onChangeNestedValue.bind(this, "rewards", "exp")}
          />
        </div>
        <div>
          <label htmlFor="gold">Gold Reward: </label>
          <input
            name="gold"
            type="number"
            placeholder="Gold Reward"
            value={this.state.data.rewards && this.state.data.rewards.gold}
            onChange={this._onChangeNestedValue.bind(this, "rewards", "gold")}
          />
        </div>
        {itemRewards}
        <div>
          <button onClick={this._onAddItemReward}>Add an item reward</button>
        </div>

        <hr />
        <h3>Prerequisites</h3>
        {prerequisites}
        <button onClick={this._onAddPrerequisite}>
          Add a Prerequisite Quest
        </button>
        <hr />
        <h3>Objectives</h3>
        {objectives}
        <button onClick={this._onAddObjective}>Add an objective</button>
        <hr />
        <button className="neutral" onClick={this.props.onCancel}>
          Cancel
        </button>
        <button onClick={this._onSave}>Save</button>
      </div>
    );
  }
}

export default EditQuestDialog;
