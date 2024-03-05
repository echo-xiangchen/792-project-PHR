//redux
import { useSelector, useDispatch } from 'react-redux';
import { addMessage, deleteMessage } from './redux/chatSlice'

//react
import { useState } from 'react'

//antd
import { 
    Avatar, 
    message,
    Upload,
    TimePicker,
    InputNumber,
} from 'antd';
import { 
    SendOutlined,
    InboxOutlined,
    UpOutlined,
    DownOutlined 
} from '@ant-design/icons'

//icon
import echoAvatar from './assets/echo.jpg'
import avatarExample from './assets/example.jpg'

//framer-motion
import { motion } from 'framer-motion'

//axios
import axios from 'axios';





const DiabetesRecord = () => {
    const { Dragger } = Upload;
    const props = {
        name: 'file',
        multiple: true,
        action: 'https://i.pravatar.cc/150?u=1',
        onChange(info) {
            const { status } = info.file;
            if (status !== 'uploading') {
                console.log(info.file, info.fileList);
            }
            if (status === 'done') {
                message.success(`${info.file.name} file uploaded successfully.`);
            } else if (status === 'error') {
                message.error(`${info.file.name} file upload failed.`);
            }
        },
        onDrop(e) {
            console.log('Dropped files', e.dataTransfer.files);
        },
    };
    const [ isShow, setIsShow ] = useState(true)
    const onChange = (time, timeString) => {
        console.log(time, timeString);
    };
    return(
        <div className='w-full flex justify-center flex-col gap-5'>
            <div className='self-center w-10 h-10 rounded-full shadow-product flex justify-center items-center text-xl font-semibold' onClick={() => setIsShow(!isShow)}>{!isShow ? <UpOutlined /> : <DownOutlined />}</div>
            {isShow && 
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 1 }}
                className="w-full flex flex-col gap-3"
            >
                <Dragger {...props}>
                    <p className="ant-upload-drag-icon">
                        <InboxOutlined />
                    </p>
                    <p className="text-xl">Click or drag file to this area to upload</p>
                </Dragger>
                <div className='w-full flex justify-center items-center gap-5'>
                    <span className='text-sm md:text-xl'>DiabetesRange</span><InputNumber size="large" min={1} max={100000} defaultValue={3} onChange={onChange} />
                    <span className='text-sm md:text-xl'>Date</span><TimePicker use12Hours format="h:mm a" onChange={onChange} />
                </div>
            </motion.div>
            }
        </div>

    )
}

const UploadBar = () => {

    const [text, setText] = useState('')

    const dispatch = useDispatch();
    //send message
    const handleSend = (message) => {
        dispatch(addMessage(message));
        askChatGPT({input: message.text});
    };
    
    const handleDelete = (index) => {
        dispatch(deleteMessage(index));
    };
    

    const askChatGPT = async ({input}) => {
        if (input.trim() === '') return;

        const payload = {
            model: "gpt-4-0125-preview", // GPT-4 IF Include image, using 'gpt-4-vision-preview'
            prompt: input,
            temperature: 0.7,
        };

        try {
            const response = await fetch(`http://localhost:3000/gpt`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ message: input }),
            });
            if(response.ok){
                const data = await response.json();
                const newMessage = {
                type: 'message',
                avatar: 'https://i.pravatar.cc/150?u=1',
                text: data.gptResponse,
                time: new Date().toISOString()
            };
            dispatch(addMessage(newMessage));
            }
            
        }catch (error) {
            console.error('Failed to send the question:', error);
        }
    }


    const handleSearch = (e) => {
        e.preventDefault()
        //record the time
        const time = new Date().toISOString();
        if(text === ''){
            message.error('Input can not be empty!')
            return
        }
        handleSend({
            type: 'message',
            avatar: echoAvatar,
            text: text,
            time: time
        });
        setText('')
    }

    return(
        <div className={`w-full flex flex-col gap-5`}>
            
            <div className='w-full flex flex-col gap-8'>
                <DiabetesRecord />
            </div>
            <form onSubmit={handleSearch} className="w-full mb-3 px-2 flex items-center border border-primary rounded-lg">
                <input
                    type="text"
                    placeholder="Ask something to your doctor..."
                    value={text}
                    onChange={(e) => setText(e.target.value)}
                    className="px-1 md:px-2 py-4 w-full focus:outline-none focus:border-none"
                />
                <button
                    className="p-2"
                    type="submit"
                    
                >
                    <SendOutlined className="h-5 w-5" />
                </button>
            </form>
        </div>
    )
}

export default UploadBar;