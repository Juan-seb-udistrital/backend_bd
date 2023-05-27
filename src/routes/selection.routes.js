import {Router} from 'express'
import {conn} from '../connector.js'

const router = Router()

router.get('/participants', (req, res) => {
  res.send('participants')
})

export default router