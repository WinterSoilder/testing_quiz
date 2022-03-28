const { Prisma, PrismaClient } = require("@prisma/client");
const bodyParser = require("body-parser");
const express = require("express");
const app = express()
const router = require('express').Router();
const cors = require('cors')

const _ = require("lodash")
const NodeCache = require("node-cache");
const path = require("path");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(cors())

const userQuiz = new NodeCache();
const prisma = new PrismaClient();

const getRandomDistinctQuestionByLevel = async (level) => {
    const result = await prisma.$queryRaw(
        Prisma.sql`select distinct question, id from question where level_id=${level} order by rand() limit 1`
    )
    const options = await prisma.option.findMany({
        where: {
            question_id: result[0].id,
        }
    })
    let question = {
        question: result[0],
        options: options
    }
    return question;
}

const getAnswerByQuestionId = async (question_id) => {
    const answer = await prisma.answer.findUnique({
        where: {
            question_id: question_id,
        }
    })
    return answer.option_id
}

app.post('/quiz_me', async (req, res) => {
    let question = {};

    let getReport = (report) => {
        let totalMarks = Object.keys(report).reduce(function (previous, key) {
            return previous + report[key]['correct_tries'];
        }, 0);
        if (totalMarks == 6) {
            res.json({ result: 'pass', totalMarks: totalMarks })
            return true;
        }
        return false
    }
    if (userQuiz.get("level") == undefined) {
        userQuiz.set("level", 1);
        userQuiz.set("count", 0);
        userQuiz.set("report", { '1': { wrong_tries: 0, correct_tries: 0 }, '2': { wrong_tries: 0, correct_tries: 0 }, '3': { wrong_tries: 0, correct_tries: 0 } })
        question = await getRandomDistinctQuestionByLevel(1)
        res.json(question)
        return;
    } else {


        userQuiz.set('count', userQuiz.get('count') + 1)
        //progress to next level if consequitively answered right 
        if (req.body.option == await getAnswerByQuestionId(req.body.question_id) && userQuiz.get('count') == 1) {
            question = await getRandomDistinctQuestionByLevel(userQuiz.get('level'))
            res.json(question)
        } else if (req.body.option == await getAnswerByQuestionId(req.body.question_id) && userQuiz.get('count') > 1) {
            userQuiz.set('count', 0)
            let report = userQuiz.get('report')
            userQuiz.set('report', report)
            report[userQuiz.get('level')]['correct_tries'] += 2
            userQuiz.set('report', report)
            if (!getReport(report)) {
                userQuiz.set('level', userQuiz.get('level') + 1)
                question = await getRandomDistinctQuestionByLevel(userQuiz.get('level'))
                res.json(question)
            }
        }
        //progress one level down if wrong answer unless level 1
        else if (req.body.option != await getAnswerByQuestionId(req.body.question_id) && userQuiz.get('level') > 1) {
            userQuiz.set('count', 0)
            let report = userQuiz.get('report')

            if (report[userQuiz.get('level') - 1] == undefined) {
                report[userQuiz.get('level') - 1] = {}
                report[userQuiz.get('level') - 1]['wrong_tries'] = 1
                userQuiz.set('report', report)
            } else {
                report[userQuiz.get('level') - 1]['wrong_tries'] += 1
                userQuiz.set('report', report)
            }

            if ((report[userQuiz.get('level') - 1]['correct_tries'] + report[userQuiz.get('level') - 1]['wrong_tries']) == 5) {
                let totalMarks = Object.keys(report).reduce(function (previous, key) {
                    return previous + report[key]['correct_tries'];
                }, 0);
                res.json({ result: 'fail', totalMarks: totalMarks })
                return;
            }

            question = await getRandomDistinctQuestionByLevel(userQuiz.get('level') - 1)
            res.json(question)
        }
        else if (req.body.option != await getAnswerByQuestionId(req.body.question_id) && userQuiz.get('level') == 1) {
            userQuiz.set('count', 0)
            userQuiz.set('level', 1)
            let report = userQuiz.get('report')
            if (report[1] == undefined) {
                report[1] = {}
                report[1]['wrong_tries'] = 1
                userQuiz.set('report', report)
            } else {
                report[1]['wrong_tries'] += 1
                userQuiz.set('report', report)
            }
            if ((report[1]['correct_tries'] + report[1]['wrong_tries']) == 5) {
                let totalMarks = Object.keys(report).reduce(function (previous, key) {
                    return previous + report[key]['correct_tries'];
                }, 0);
                res.json({ result: 'fail', totalMarks: totalMarks })
                return;
            }

            question = await getRandomDistinctQuestionByLevel(userQuiz.set('level', 1))
            res.json(question)
        }
    };

})

app.post("/logout", (req, res) => {
    userQuiz.flushAll()
    res.json({ status: 'success' })
})

app.use(express.static(path.join(__dirname, '/build/')));

app.listen(5000, () => {
    console.log("Listening on port 5000")
})
