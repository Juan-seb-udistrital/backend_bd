import { Router } from 'express'
import { conn } from '../connector.js'

const router = Router()

router.get('/participants', async (req, res) => {
  try {
    const response = await conn.execute(`select e.codestudiante, e.nombrees,e.apellidoes, r.nomunidad,u.nomunidad,i.nominstrumento,c.calificacion
    from estudiante e, convocatoriaestudiante c,instrumento i, obra o, periodo p, unidad u, unidad r, tipounidad t
    where e.codestudiante=c.codestudianteFK and u.codunidad=e.codunidadFFK and i.idinstrumento=c.idinstrumentoFK and c.idobraFK=o.idobra 
    and t.tipounidad=r.tipounidadFK and r.codunidad=u.Uni_codunidad
    and o.idperiodo=p.idperiodo and (i.idinstrumento, i.nominstrumento,c.calificacion) in 
    (select i.idinstrumento, i.nominstrumento,max(c.calificacion) from convocatoriaestudiante c, instrumento i 
    where  i.idinstrumento=c.idinstrumentoFK GROUP by i.idinstrumento,i.nominstrumento)`)

    const mapResponse = response.rows.map(row => {
      return {
        id: row[0],
        first_name: row[1],
        last_name: row[2],
        project: row[3],
        degree: `${row[3]} - ${row[4]}`,
        instrument: row[5],
        rating: row[6]
      }
    })

    res.send(mapResponse)
  } catch (err) {
    console.log(err)
  }
})

router.post('/insertParticipant', async (req, res) => {
  try {
    const { id } = req.body
    const response = await conn.execute(`insert into ParticipacionEstudiante VALUES (cpartest.nextval,:id,'Cs','ob1','3')`, { id }, { autoCommit: true })

    if (response) {
      res.send({
        inserted: true
      }) 
    }
  }catch(err){
    res.send({
      error: true
    })
  }
})

export default router