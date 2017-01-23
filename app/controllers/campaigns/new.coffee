`import Ember from 'ember';`
`import ENV from 'simplify-selfcare/config/environment';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')
  session: Ember.inject.service()

  showNewUi: Ember.computed 'applicationController.location.id', ->
    @get('applicationController.location.ui')

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

  newFilter: Ember.computed 'model.id', ->
    @store.createRecord 'filter',
      all: true

  actions:
    create: ->
      newCampaign = @get('model')
      kind = @get('model.kind')
      if kind == 'email'
        newCampaign.set 'message', CKEDITOR.instances['campaign-content'].getData()
      newCampaign.set 'location', @store.peekRecord('location', @get('locationId'))

      filterType = @get 'filterType'
      if filterType != 'previous'
        filter = @get('newFilter')
        filter.save().then =>
          newCampaign.set 'filter', filter
          newCampaign.save().then =>
            @transitionToRoute('campaigns.index')
      else
        newCampaign.save().then =>
          @transitionToRoute('campaigns.index')

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
