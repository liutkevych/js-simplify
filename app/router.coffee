`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'sign-in'
  @route 'dashboard',
    path: '/'
  @route 'visitors', ->
    @route 'emails'
    @route 'phones'

`export default Router;`
