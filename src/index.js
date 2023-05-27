import express from 'express'
import {conn} from './connector.js'
import routesCalendar from './routes/calendar.routes.js'
import cors from 'cors'

const app = express()
app.use(cors())
app.use(express.json())
app.use('/calendar' , routesCalendar)

app.listen(3000, () => {
  console.log('Server running on port 3000')
})
/* const connection = await getConnectionDB() */
/* const res = await conn.execute('SELECT * FROM S_EMP')
console.log(res) */