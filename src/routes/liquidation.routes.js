import { conn } from '../connector.js'
import { Router } from 'express'

const router = Router()

router.get('/reports', async (req, res) => {
  try{
    const request = await conn.execute(`Select distinct ENSAYO.CODESTUDIANTE, ENSAYO.NOMBRE , NVL(ENSAYO.HEnsayo,0)*2+NVL(Funcion.Hfuncion,0)*4 TOTAL
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
        hours: row[2]
      }
    })

    res.send(response)

  }catch(err){
    
  }
})

export default router