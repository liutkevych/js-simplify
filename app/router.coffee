`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'sign-in'
  @route 'sign-out'

  @route 'home',
    path: '/'

  @route 'stats'

  @route 'campaigns', ->
    @route 'new'
    @route 'edit',
      path: '/:id/edit'
    @route 'targets',
      path: '/:id/targets'

`export default Router;`
