`import DS from 'ember-data';`

FilterModel = DS.Model.extend
  all:           DS.attr()
  dateStart:     DS.attr()
  dateEnd:       DS.attr()
  frequencyFrom: DS.attr()
  frequencyTo:   DS.attr()
  geography:     DS.attr()
  gender:        DS.attr()
  ageFrom:       DS.attr()
  ageTo:         DS.attr()

`export default FilterModel;`
