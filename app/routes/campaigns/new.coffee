`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampaignsNewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service()

  model: ->
    @store.createRecord 'campaign',
      kind: 'sms'

  deactivate: ->
    @controllerFor('campaigns.new').get('model').deleteRecord()

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'locations', @store.findAll 'location'

`export default CampaignsNewRoute;`
