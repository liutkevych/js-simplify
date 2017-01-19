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

  checkboxesFixer: Ember.observer 'startDateChecked', 'endDateChecked', 'frequencyChecked', 'geographyChecked', 'genderChecked', 'ageChecked', ->
    newValue = !(@get('startDateChecked') || @get('endDateChecked') || @get('frequencyChecked') || @get('geographyChecked') || @get('genderChecked') || @get('ageChecked'))
    @set('filter.all', newValue)

`export default TargetsFiltersComponent`
