const AWS = require('aws-sdk');

exports.handler = (event, context) => {
  const payload = JSON.parse(event.body);

  if (payload && payload.commits) {
    const changedFiles = [];

    for (const commit of payload.commits) {
      for (const file of commit.modified) {
        if (!changedFiles.includes(file)) {
          changedFiles.push(file);
        }
      }
      for (const file of commit.added) {
        if (!changedFiles.includes(file)) {
          changedFiles.push(file);
        }
      }
      for (const file of commit.removed) {
        if (!changedFiles.includes(file)) {
          changedFiles.push(file);
        }
      }
    }
    
    console.log(changedFiles)
    
    if (changedFiles.length > 0) {
      changedFiles.forEach((changedFiles) => {
        const pathElements = changedFiles.split('/');
        var firstSubFile;
        var srcIndex;
        
        if(changedFiles.split('/').indexOf('on-cloud-backend-microservices') !== -1) {
          srcIndex = changedFiles.split('/').indexOf('on-cloud-backend-microservices');
          firstSubFile = pathElements[srcIndex + 1];
        } else if (changedFiles.split('/').indexOf('frontend') == 0) {
          srcIndex = 0;
          firstSubFile = "frontend";
        }

        if (srcIndex !== -1 && srcIndex < pathElements.length - 1) {
          
          var pipelineName = "gr3-thangtd18-prod-" + firstSubFile + "-pipeline";
          
          console.log(pipelineName)
          // Start pipeline
          let codepipeline = new AWS.CodePipeline();
          
          codepipeline.startPipelineExecution({ name: pipelineName }, function(err, data) {
            if (err) console.log(err, err.stack); // an error occurred
            else     console.log(data);           // successful response
          });
          
          console.log('finished');
        } else {
          console.log('No subfile found after "src"');
        }
        // Perform further operations with each filePath
      });
    }
  }
  
  return {
    statusCode: 200,
    body: 'Webhook received successfully',
  };
};