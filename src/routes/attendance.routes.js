import { conn } from '../connector.js'
import { Router } from 'express'

const router = Router()

router.get('/todayAttendance', async (req, res) => {
  try {
    const request = await conn.execute(`SELECT E.CODESTUDIANTE, E.NOMBREES, E.apellidoes
    FROM  PERIODO P ,OBRA  O, CALENDARIO C, TIPOCALENDARIO T, ESTUDIANTE E, PARTICIPACIONESTUDIANTE R
    WHERE  P.IDPERIODO=O.IDPERIODO   and O.IDOBRA =C.IDOBRAKFK AND T.IDTIPOCALEN=C.IDTIPOCALENPKFK
    AND E.CODESTUDIANTE=R.CODESTUDIANTEPKFK AND R.IDTIPOCALENPKFK=C.IDTIPOCALENPKFK AND R.IDOBRAFFK=O.IDOBRA
    and lower(R.IDTIPOCALENPKFK) LIKE 'cs'`)

    const students = request.rows.map(row => {
      return {
        id: row[0],
        name: `${row[1]} ${row[2]}`,
      }
    })

    res.send({
      students,
      activity:{
        id: getActivity.rows[0][0],
        name: getActivity.rows[0][1]
      }
    })
  } catch (err) {
    console.log(err)
  }
})

router.get('/reportAttendance', async(req, res)=>{
  try{
    const request = await conn.execute(`Select distinct ENSAYO.CODESTUDIANTE, ENSAYO.NOMBRE , NVL(ENSAYO.HEnsayo,0)+NVL(Funcion.Hfuncion,0) TOTAL
    From (SELECT E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES NOMBRE, COUNT(E.CODESTUDIANTE) HEnsayo FROM 
    CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'ce'
    GROUP BY E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES) Ensayo LEFT JOIN
    (SELECT E.CODESTUDIANTE,COUNT(E.CODESTUDIANTE) Hfuncion FROM CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'cf'
    GROUP BY E.CODESTUDIANTE) Funcion ON ENSAYO.CODESTUDIANTE=FUNCION.CODESTUDIANTE`)

    const response = request.rows.map(row => { 
      return {
        id: row[0],
        name: row[1],
        attendance: row[2]
      }
    })
    res.send(response)
  }catch(err){
    console.log(err)
  }
})

router.post('/registerAttendance', async (req, res) => {
  try{
    const {id, id_calendar} = req.body

    await conn.execute(`insert into ParticipacionEstudiante VALUES (cpartest.nextval,${id},'Ce','ob1','${id_calendar}')`,{},{autoCommit: true})

    res.send({
      inserted: true
    })
  }catch(err){
    console.log(err)
  }
})

export default router