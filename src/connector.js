import pkg from 'oracledb'

let conn = null
const config = {
  user: 'BD2023',
  password: 'JUANBD',
  connectString: 'localhost:1521'
}

try{
  conn = await pkg.getConnection(config)
}catch(err){
  console.log('Ouch!', err)
}

export {conn}