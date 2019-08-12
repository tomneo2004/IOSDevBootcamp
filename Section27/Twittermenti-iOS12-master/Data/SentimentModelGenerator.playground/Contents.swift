import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/volumes/bootcamp/iosdevbootcamp/Section27/Twittermenti-iOS12-master/data/twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentTextCassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentTextCassifier.evaluation(on: testingData)
let evalutionAccuracy = (1.0-evaluationMetrics.classificationError)*100

try sentimentTextCassifier.prediction(from: "Today's weather is bad")
try sentimentTextCassifier.prediction(from: "I found a good place to live")
try sentimentTextCassifier.prediction(from: "I learn a new knowledge")
try sentimentTextCassifier.prediction(from: "This food is good")

let metadata = MLModelMetadata(author: "Nelson", shortDescription: "Sentiment model for twitter", license: "MIT", version: "1.0")

try sentimentTextCassifier.write(to: URL(fileURLWithPath: "/volumes/bootcamp/iosdevbootcamp/Section27/Twittermenti-iOS12-master/data/sentimentTweet.mlmodel"), metadata: metadata)
