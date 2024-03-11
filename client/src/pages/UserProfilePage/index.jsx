import React from 'react'

//component
import SideBar from './sideBar'

//style
import { pageSetting } from '../../styles'

const UserProfilePage = () => {
  return (
    <div className={`${pageSetting.padding} pt-36 flex gap-12`}>
      <SideBar />
      <div className='flex-1'>
        <h1>User Profile Page</h1>
      </div>
    </div>
  )
}

export default UserProfilePage