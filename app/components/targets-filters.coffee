`import Ember from 'ember'`

TargetsFiltersComponent = Ember.Component.extend
  classNames: ['targets']
  filterType: 'all'

  showCustomFilter: Ember.computed 'filterType', ->
    filterType = @get('filterType')
    filterType != 'previous'

  showPreviousCampaignsDropdown: Ember.computed 'filterType', ->
    filterType = @get('filterType')
    filterType == 'previous'

  startDateDisabled: Ember.computed 'startDateChecked', 'filterDisabled', ->
    @get('filterDisabled') || !@get('startDateChecked')

  endDateDisabled: Ember.computed 'endDateChecked', 'filterDisabled', ->
    @get('filterDisabled') || !@get('endDateChecked')

  frequencyDisabled: Ember.computed 'frequencyChecked', 'filterDisabled', ->
    @get('filterDisabled') || !@get('frequencyChecked')

  geographyDisabled: Ember.computed 'geographyChecked', 'filterDisabled', ->
    @get('filterDisabled') || !@get('geographyChecked')

  genderDisabled: Ember.computed 'genderChecked', 'filterDisabled', ->
    @get('filterDisabled') || !@get('genderChecked')

  ageDisabled: Ember.computed 'ageChecked', 'filterDisabled', ->
    @get('filterDisabled') || !@get('ageChecked')

  checkboxesFixer: Ember.observer 'startDateChecked', 'endDateChecked', 'frequencyChecked', 'geographyChecked', 'genderChecked', 'ageChecked', ->
    newValue = !(@get('startDateChecked') || @get('endDateChecked') || @get('frequencyChecked') || @get('geographyChecked') || @get('genderChecked') || @get('ageChecked'))
    @set('filter.all', newValue)

  allObserver: Ember.observer 'filter.all', ->
    if @get('filter.all')
      @setProperties
        startDateChecked:   false
        frequencyChecked:   false
        geographyChecked:   false
        endDateChecked:     false
        genderChecked:      false
        ageChecked:         false
        "filter.dateStart":     null
        "filter.dateEnd":       null
        "filter.frequencyFrom": null
        "filter.frequencyTo":   null
        "filter.geography":     null
        "filter.ageFrom":       null
        "filter.ageTo":         null
        "filter.gender":        null

  filterDisabled:   true
  showDelaySection: false

  filterTypeObserver: Ember.observer 'filterType', ->
    filterType = @get('filterType')
    switch filterType
      when 'all'
        @setProperties
          'filterDisabled': true
          'filter.all':     true
      when 'new'
        @set 'filter.all', true
        @set 'filter.all', false

        @setProperties
          'filterDisabled':     true
          'frequencyChecked':   true
          'filter.frequencyTo': 1
      when 'top'
        @set 'filter.all', true
        @set 'filter.all', false

        @setProperties
          'filterDisabled':       true
          'frequencyChecked':     true
          'filter.frequencyFrom': 5
      when 'custom'
        @setProperties
          'filterDisabled': false
          'filter.all':     true

  actions:
    selectFilterType: (value) ->
      @set 'filterType', value

    selectPreviousCampaign: (value) ->
      @set 'filter.previous', value

`export default TargetsFiltersComponent`
