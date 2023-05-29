import express from 'express'
import routesNavbar from './routes/navbar.routes.js'
import routesCalendar from './routes/calendar.routes.js'
import routesSelection from './routes/selection.routes.js'
import routesAttendance from './routes/attendance.routes.js'
import routesLiquidation from './routes/liquidation.routes.js'
import cors from 'cors'

const app = express()
app.use(cors())
app.use(express.json())
app.use('/navbar' , routesNavbar)
app.use('/calendar' , routesCalendar)
app.use('/selection', routesSelection)
app.use('/attendance', routesAttendance)
app.use('/liquidation', routesLiquidation)

app.listen(3000, () => {
  console.log('Server running on port 3000')
})
