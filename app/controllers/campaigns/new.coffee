`import Ember from 'ember';`
`import ENV from 'simplify-selfcare/config/environment';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')
  session: Ember.inject.service()
  newFilterChecked: true

  toggleFiltersView: Ember.observer 'newFilterChecked', ->
    show = @get('newFilterChecked')
    if show
      $('.filters-view').slideDown(128)
    else
      $('.filters-view').slideUp(128)

  campaigns: Ember.computed 'applicationController.locationId', ->
    locationId = @get('applicationController.locationId')
    return unless locationId

    @store.query 'campaign',
      location_id: locationId

  symbolsLeft: Ember.computed 'model.message.length', ->
    contentLength = @get('model.message.length')
    if contentLength
      160 - contentLength
    else
      160

  baseFilter: Ember.computed 'model', ->
    @store.createRecord 'filter',
      all: true

  actions:
    create: ->
      newCampaign = @get('model')
      kind = @get('model.kind')
      if kind == 'email'
        newCampaign.set 'message', CKEDITOR.instances['campaign-content'].getData()
      newCampaign.set 'location', @store.peekRecord('location', @get('locationId'))

      setFiltersAndSave = =>
        filters = []
        $('.filter:checked').each (i, checkbox) ->
          filters.push $(checkbox).attr('name')
        newCampaign.set('filters', filters)
        newCampaign.save().then =>
          @transitionToRoute('campaigns.index')

      if @get('newFilterChecked')
        baseFilter = @get('baseFilter')
        baseFilter.save().then =>
          newCampaign.set 'baseFilter', baseFilter
          setFiltersAndSave()
      else
        setFiltersAndSave()

      return false

    changeKind: (e) ->
      $('.btn-group .btn').removeClass('active')
      $target = $(e.target)
      $target.addClass('active')
      newKind = $target.attr('kind')
      @set 'model.kind', newKind
      if newKind == 'email'
        CKEDITOR.replace 'campaign-content'
      else if newKind == 'sms' && $('#cke_campaign-content').length > 0
        CKEDITOR.instances['campaign-content'].destroy()

`export default CampaignsNewController;`
