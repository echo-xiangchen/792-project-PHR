
//antd
import { Modal } from 'antd';

const DataAddModal = ({title, isModalVisible,setIsModalVisible, children}) => {
    return (
        <Modal 
            height={400}
            title={title} 
            open={isModalVisible} 
            footer={null} 
            centered
            onCancel={()=>setIsModalVisible(false)}>
            {children}
        </Modal>
    )
}

export default DataAddModal;