import {Router} from 'express'
import {conn} from '../connector.js'

const router = Router()

router.get('/events', async (req, res) => {
  try{
    const eventsDB = await conn.execute(`SELECT 'Actividad: '|| TC.DESCTIPOCALENDARIO Actividad, 'Obra: '|| O.TITULO OBRA, to_char(C.FECHAINICIO,'yyyy/mm/dd hh24:mi:ss') INICIO_ACTIVIDAD, to_char(C.FECHAFIN,'yyyy/mm/dd hh24:mi:ss') FINAL_ACTIVIDAD FROM CALENDARIO C, TIPOCALENDARIO TC, OBRA O WHERE O.IDOBRA=C.IDOBRAKFK AND TC.IDTIPOCALEN=C.IDTIPOCALENPKFK`)
    
    const response = eventsDB.rows.map((row,index)=> {
      return {
        id: index + 1,
        title: `${row[0]} - ${row[1]}`,
        start: new Date(row[2]),
        end: new Date(row[3])
      }
    })

    res.send(response)

  }catch(err){
    console.log(err)
  }
})

router.patch('/inactiveParticipation', async (req, res) => {
  try {
    let state = null

    const getActive = await conn.execute(`SELECT IDESTADO FROM ESTADO WHERE LOWER(IDESTADO) NOT LIKE 'activo%'`)
    state = getActive.rows[0][0]
    
    const inactiveParticipation = await conn.execute(`UPDATE CALENDARIO SET IDESTADOFK=:state WHERE CONSECALENDARIO=1`,{state},{
      autoCommit: true,
      outFormat: conn.OBJECT
    })
    console.log(inactiveParticipation)
    res.send(inactiveParticipation)
  }catch(err){
    console.log(err)
  }
})

export default router
