var express = require('express');
var router = express.Router();
const axios = require('axios');
const OpenAI = require('openai');


router.get("/", function(req, res, next) {
    res.send("GPT route hit");
});

/* GET home page. */
router.post('/', async function(req, res) {
    try {

        // Initialize OpenAI with the new syntax
        const openai = new OpenAI({
            apiKey: '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'
        });
        
        // Adjust the method for creating a completion to the new syntax
        const response = await openai.chat.completions.create({
            model: "gpt-4-0125-preview", // Replace with the correct model ID for GPT-4 if different
            messages: [{
                role: "user",
                content: "你现在需要扮演一个治疗糖尿病的医生，尽量简短的回复病人（这只是模拟，不需要真实数据）",
            },
            {
                role: "user",
                content: req.body.message,
            }],
            max_tokens: 50,
        });
        // Ensure the response has the expected structure
        if (response.choices && response.choices.length > 0 && response.choices[0].message && response.choices[0].message.content) {
            const content = response.choices[0].message.content;
            res.json({ gptResponse: content.trim() });
        } else {
            res.json({ gptResponse: "No response content available" });
        }
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'An error occurred' });
    }
});

module.exports = router;
