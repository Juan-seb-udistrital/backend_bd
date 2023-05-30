import { conn } from '../connector.js'
import { Router } from 'express'
import pkg from 'nodemailer'

const router = Router()

router.get('/reports', async (req, res) => {
  try {
    const request = await conn.execute(`Select A.CODESTUDIANTE,A.NOMBRE , A.TOTAL, U_E.NOMUNIDAD POYECTO,U_P.NOMUNIDAD FACULTAD FROM (Select distinct ENSAYO.CODESTUDIANTE, ENSAYO.NOMBRE , NVL(ENSAYO.HEnsayo,0)*2+NVL(Funcion.Hfuncion,0)*4 TOTAL
    From (SELECT E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES NOMBRE, COUNT(E.CODESTUDIANTE) HEnsayo FROM 
    CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'ce'
    GROUP BY E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES) Ensayo LEFT JOIN
    (SELECT E.CODESTUDIANTE,COUNT(E.CODESTUDIANTE) Hfuncion FROM CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'cf'
    GROUP BY E.CODESTUDIANTE) Funcion ON ENSAYO.CODESTUDIANTE=FUNCION.CODESTUDIANTE) A , ESTUDIANTE E, UNIDAD U_E ,UNIDAD U_P
    WHERE E.CODESTUDIANTE = A.CODESTUDIANTE and  U_E.CODUNIDAD=E.CODUNIDADFFK and U_E.UNI_CODUNIDAD=U_P.CODUNIDAD`)

    const response = request.rows.map(row => {
      return {
        id: row[0],
        name: row[1],
        project: `${row[4]} - ${row[3]}`,
        hours: row[2]
      }
    })

    res.send(response)

  } catch (err) {
    console.log(err)
  }
})

router.get('/sendEmails', async (req, res) => {
  let usersToEmail = null

  try {
    const request = await conn.execut(`Select A.CODESTUDIANTE,A.NOMBRE , A.TOTAL, U_E.NOMUNIDAD POYECTO,U_P.NOMUNIDAD FACULTAD, e.correo
    FROM (Select distinct ENSAYO.CODESTUDIANTE, ENSAYO.NOMBRE , NVL(ENSAYO.HEnsayo,0)*2+NVL(Funcion.Hfuncion,0)*4 TOTAL
    From (SELECT E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES NOMBRE, COUNT(E.CODESTUDIANTE) HEnsayo FROM 
    CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'ce'
    GROUP BY E.CODESTUDIANTE, E.NOMBREES ||' '|| E.APELLIDOES) Ensayo LEFT JOIN
    (SELECT E.CODESTUDIANTE,COUNT(E.CODESTUDIANTE) Hfuncion FROM CALENDARIO C, PARTICIPACIONESTUDIANTE P, ESTUDIANTE E
    WHERE C.CONSECALENDARIO=P.CONSECALENDARIO and C.IDTIPOCALENPKFK=P.IDTIPOCALENPKFK and C.IDOBRAKFK =P.IDOBRAFFK and E.CODESTUDIANTE = P.CODESTUDIANTEPKFK and lower(C.IDTIPOCALENPKFK) LIKE 'cf'
    GROUP BY E.CODESTUDIANTE) Funcion ON ENSAYO.CODESTUDIANTE=FUNCION.CODESTUDIANTE) A , ESTUDIANTE E, UNIDAD U_E ,UNIDAD U_P
    WHERE E.CODESTUDIANTE = A.CODESTUDIANTE and  U_E.CODUNIDAD=E.CODUNIDADFFK and U_E.UNI_CODUNIDAD=U_P.CODUNIDAD
    and A.total =(select sum(to_char(fechafin,'HH24')-to_char(fechainicio,'HH24'))
    from calendario  WHERE LOWER(idtipocalenPKFK) IN ('ce','cf'))`)

    usersToEmail = request.rows.map(row => {
      return {
        id: row[0],
        name: row[1],
        project: `${row[4]} - ${row[3]}`,
        hours: row[2],
        email: row[5]
      }
    })

  } catch (err) {
    console.log(err)
  }

  usersToEmail.forEach(user=>{

    pkg.createTestAccount((err, account) => {
      const htmlMail = `<div style="width: 100%; background-color: rgb(109, 109, 109); border-radius: 20px; border: 1px solid black; text-align: center; color: aliceblue;">
                                <p>Electiva cursada en el grupo Sinfonica UD - periodo 20231 e informando 
                                al proyecto curricular ${user.project}  que el estudiante ${user.name} con codigo ${user.id} curso la electiva 
                                participación sinfonicaUD durante el período 20231 con una cantidad de horas de ${user.hours}.</p>
                            </div>`;
      const transporter = pkg.createTransport({
        host: 'smtp.gmail.com',
        port: '465',
        secure: true,
        auth: {
          user: 'johanaguirrediaz244@gmail.com',
          pass: 'mwefnwpaenhfijtz'
        }
      });
      const mailOptions = {
        from: 'johanaguirrediaz244@gmail.com',
        to: user.email,
        replyTo: 'correo origen',
        subject: 'Electiva cursada en el grupo Sinfonica UD - periodo 20231',
        text: '',
        html: htmlMail
      };
      transporter.sendMail(mailOptions, (err, info) => {
        if (err) {
          return console.log(err);
        }
        console.log('Mensaje enviado', info.mensaje);
        console.log('url del mensaje', pkg.getTestMessageUrl(info));
      })
    })
  })

  res.send({
    emailsSent: true
  })
})

router.patch('/updateAllCalendar', async (req, res) => {
  try {
    await conn.execute(`UPDATE CALENDARIO 
    SET IDESTADOFK='Inactivo'
    WHERE lower(IDTIPOCALENPKFK) IN ('cs','ce','cf')`, {}, { autoCommit: true })

    res.send({
      allUpdated: true
    })
  } catch (err) {
    console.log(err)
  }
})

export default router