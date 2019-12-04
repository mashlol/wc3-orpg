const validateObj = function(obj, fields) {
  for (const key in fields) {
    if (obj[key] == null) {
      return "Missing " + fields[key];
    }
  }
  return null;
}

const validateItem = function(item) {
  const mandatoryItemFields = {
    name: "name",
    icon: "icon",
    requiredLevel: 'required level',
    rarity: 'rarity',
    itemLevel: 'item level',
    cost: 'cost',
    classification: 'classification',
  };

  const mandatoryEquipmentFields = {
    type: 'type',
    stats: 'stats',
  };

  const mandatoryConsumableFields = {
    stackSize: 'stack size',
    tooltip: 'tooltip',
  };

  const res = validateObj(item, mandatoryItemFields);
  if (res) return res;

  if (item.classification === 'Equipment') {
    const res = validateObj(item, mandatoryEquipmentFields);
    if (res) return res;
  }
  if (item.classification === 'Consumable') {
    const res = validateObj(item, mandatoryConsumableFields);
    if (res) return res;
  }

  return true;
}

const validateQuest = function(quest) {
  const mandatoryQuestFields = {
    name: 'name',
    getQuestFrom: 'quest giver',
    handQuestTo: 'quest receiver',
    obtainText: 'obtain text',
    incompleteText: 'incomplete text',
    completedText: 'completed text',
    levelRequirement: 'level requirement',
    rewards: 'rewards',
  };

  const mandatoryObjectiveFields = {
    type: 'objective type',
  };

  const mandatoryKillObjectiveFields = {
    amount: 'amount for kill objective',
    name: 'name of target of kill objective',
    toKill: 'toKill unitid for kill objective',
  };

  const mandatoryGatherObjectiveFields = {
    amount: 'amount for gather objective',
    itemId: 'itemId for gather objective',
  };

  const mandatoryDiscoverObjectiveFields = {
    amount: 'amount for discover objective',
    region: 'region for discover objective',
    name: 'name for discover objective',
  };

  const res = validateObj(quest, mandatoryQuestFields);
  if (res) return res;

  if (quest.objectives) {
    for (const objKey in quest.objectives) {
      const objective = quest.objectives[objKey];
      const res = validateObj(objective, mandatoryObjectiveFields);
      if (res) return res;

      if (objective.type === 'Kill') {
        const res = validateObj(objective, mandatoryKillObjectiveFields);
        if (res) return res;
      }

      if (objective.type === 'Gather') {
        const res = validateObj(objective, mandatoryGatherObjectiveFields);
        if (res) return res;
      }

      if (objective.type === 'Discover') {
        const res = validateObj(objective, mandatoryDiscoverObjectiveFields);
        if (res) return res;
      }
    }
  }

  return true;
}

const validateDropTable = function(dropTable) {
  return true;
}

const validateVendor = function(vendor) {
  return true;
}

module.exports = {
  validateItem: validateItem,
  validateQuest: validateQuest,
  validateDropTable: validateDropTable,
  validateVendor: validateVendor,
}