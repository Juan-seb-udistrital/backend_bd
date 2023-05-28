import { conn } from '../connector.js'
import { Router } from 'express'

const router = Router()

router.get('/getPlanning', async (req, res) => {
  try {
    const response = await conn.execute(`SELECT C.IDESTADOFK FROM TIPOCALENDARIO TC, CALENDARIO C WHERE TC.IDTIPOCALEN=C.IDTIPOCALENPKFK AND LOWER(C.IDESTADOFK) LIKE 'activo%' AND LOWER(TC.DESCTIPOCALENDARIO) LIKE 'planeacion%'`)

    if (response.rows.length > 0) {
      res.send({
        planning: true
      })
    }

    res.send({
      planning: false
    })
  } catch (err) {
    console.log(err)
  }
})

router.get('/getAttendance', async(req, res) => {
  const { year, month, day, hour, minute } = req.body
  console.log(year, month, day, hour, minute)
  try{
    res.send({
      year,
      month,
    })
  }catch(err){
    console.log(err)
  }
})

export default router
