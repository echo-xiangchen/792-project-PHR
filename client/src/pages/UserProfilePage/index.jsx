import React from 'react'

//component
import SideBar from './sideBar'
import { UserComponents } from '../../components'

//style
import { pageSetting } from '../../styles'

const UserProfilePage = () => {
  return (
    <div className={`${pageSetting.padding} ${pageSetting.backgroundColor} pt-36 flex gap-12`}>
      <div className='backdrop-blur-xl bg-white/50 rounded-lg shadow-product '>
        <SideBar />
      </div>
      <div className='flex-1 backdrop-blur-xl bg-white/50 rounded-lg shadow-product '>
        <UserComponents />
      </div>
    </div>
  )
}

export default UserProfilePage