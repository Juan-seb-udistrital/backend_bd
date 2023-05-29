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
      return
    }

    res.send({
      planning: false
    })
  } catch (err) {
    console.log(err)
  }
})

router.get('/getAttendance', async(req, res) => {
  try{
    const response = await conn.execute(`SELECT * FROM (SELECT C.CONSECALENDARIO, T.DESCTIPOCALENDARIO
    FROM  PERIODO P ,OBRA  O, CALENDARIO C, TIPOCALENDARIO T
    WHERE  T.IDTIPOCALEN=C.IDTIPOCALENPKFK AND O.IDOBRA=C.IDOBRAKFK AND P.IDPERIODO=O.IDPERIODO
    and TO_CHAR(SYSDATE,'YYYY')=substr(p.idperiodo,1,4) and TO_CHAR(SYSDATE,'dd/mm/YYYY hh24:mi') 
    between TO_CHAR(C.FECHAINICIO,'dd/mm/YYYY hh24:mi') and TO_CHAR(C.FECHAFIN,'dd/mm/YYYY hh24:mi')) T WHERE 
    LOWER(T.DESCTIPOCALENDARIO) LIKE 'ensayo' OR LOWER(T.DESCTIPOCALENDARIO) LIKE 'funcion' `)

    if(response.rows.length > 0){
      res.send({
        attendance: true
      })
      return
    }

    res.send({
      attendance: false
    })
  }catch(err){
    console.log(err)
  }
})

router.get('/getLiquidation', async(req, res) => {
  try{
    const response = await conn.execute(`SELECT COUNT(C.CONSECALENDARIO) NO_ACTIVDADESFALTANTES 
    FROM (SELECT Ca.FECHAFIN ULTIMAFECHA FROM (SELECT C.FECHAFIN FROM CALENDARIO C 
    ORDER BY C.FECHAFIN DESC) Ca WHERE ROWNUM=1) F ,CALENDARIO C
    WHERE C.FECHAFIN BETWEEN TO_DATE('29/05/2023','DD/MM/YY') and F.ULTIMAFECHA ORDER By C.CONSECALENDARIO`)

    if(response.rows.length > 0){
      res.send({
        liquidation: false
      })
      return
    }

    res.send({
      liquidation: true
    })
  }catch(err){
    console.log(err)
  }
})

export default router
