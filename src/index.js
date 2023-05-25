import express from 'express'
import {getConnectionDB} from './connector.js'

const app = express()

const connection = await getConnectionDB()
const res = await connection.execute('SELECT * FROM S_EMP')
console.log(res)