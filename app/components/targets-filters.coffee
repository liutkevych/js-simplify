`import Ember from 'ember'`

TargetsFiltersComponent = Ember.Component.extend
  classNames: ['targets']

  startDateDisabled: Ember.computed 'startDateChecked', ->
    !@get('startDateChecked')

  endDateDisabled: Ember.computed 'endDateChecked', ->
    !@get('endDateChecked')

  frequencyDisabled: Ember.computed 'frequencyChecked', ->
    !@get('frequencyChecked')

  geographyDisabled: Ember.computed 'geographyChecked', ->
    !@get('geographyChecked')

  genderDisabled: Ember.computed 'genderChecked', ->
    !@get('genderChecked')

  ageDisabled: Ember.computed 'ageChecked', ->
    !@get('ageChecked')

`export default TargetsFiltersComponent`
