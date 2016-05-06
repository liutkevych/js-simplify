`import Ember from 'ember';`
`import moment from 'moment';`

DashboardController = Ember.Controller.extend
  location_id: Ember.computed 'model', ->
    @get 'model.firstObject.id'

  startTime: moment().subtract(30, 'days').toDate()
  endTime: new Date()

  anyPresence: Ember.computed 'presence.id', ->
    presence = @get 'presence.details.total'
    presence && (presence.visits > 0 || presence.sessions > 0)

  presence: Ember.computed 'location_id', 'startTime', 'endTime', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'presence'
      options:
        location_id: location_id
        start_time: @get('startTime')
        end_time: @get('endTime')

  presenceDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'date', 'Date'
    dataTable.addColumn 'number', 'Visits'
    dataTable.addColumn 'number', 'Sessions'

    rows = []
    Object.keys(data).forEach (date) ->
      rows.push [new Date(date), data[date]['visits'], data[date]['sessions']]

    dataTable.addRows rows
    dataTable

  presenceChartOptions: (data) ->
      height: 400
      hAxis:
        gridlines:
          count: Object.keys(data).length / 2

  platforms: Ember.computed 'location_id', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'platforms'
      options:
        location_id: location_id

  platformsDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Platform'
    dataTable.addColumn 'number', 'Visits'

    rows = []
    Object.keys(data).forEach (platform) ->
      rows.push [platform, data[platform]]

    dataTable.addRows rows
    dataTable

  pieChartOptions: (data) ->
      height: 200
      chartArea:
        height: '90%'
        width: '100%'
      legend:
        alignment: 'center'

  registrations: Ember.computed 'location_id', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'registrations'
      options:
        location_id: location_id

  registrationsDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Source'
    dataTable.addColumn 'number', 'Registrations'

    rows = []
    Object.keys(data).forEach (source) ->
      rows.push [source, data[source]]

    dataTable.addRows rows
    dataTable

  authorizations: Ember.computed 'location_id', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'authorizations'
      options:
        location_id: location_id

  authorizationsDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Source'
    dataTable.addColumn 'number', 'Authorizations'

    rows = []
    Object.keys(data).forEach (source) ->
      rows.push [source, data[source]]

    dataTable.addRows rows
    dataTable

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

    toggleQuery: (id) ->
      $("##{id}").slideToggle(128)

`export default DashboardController;`
