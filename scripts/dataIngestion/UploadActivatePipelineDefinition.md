You must upload your pipeline definition and activate your pipeline. In the following example commands, replace pipeline_name with 
a label for your pipeline and pipeline_file with the fully-qualified path for the pipeline definition .json file.

<b>AWS CLI</b>

To create pipeline definition and activate pipeline, firstly we used the following create-pipeline command using AWS CLI. 

<code>aws datapipeline create-pipeline --name pipeline_name --unique-id token{ "pipelineId": "df-00111111PBPTABLE" }</code><br />
<code>aws datapipeline create-pipeline --name pipeline_name --unique-id token{ "pipelineId": "df-00111111PLAYERTABLE" }</code><br />
<code>aws datapipeline create-pipeline --name pipeline_name --unique-id token{ "pipelineId": "df-00111111GAMETABLE" }</code><br />
<code>aws datapipeline create-pipeline --name pipeline_name --unique-id token{ "pipelineId": "df-00111111PROBOWLTABLE" }</code><br />

To upload pipeline definition, used the following put-pipeline-definition command.

<code>
aws datapipeline put-pipeline-definition --pipeline-id df-00111111PBPTABLE --pipeline-definition file://PBP.json
</code><br />
<code>
aws datapipeline put-pipeline-definition --pipeline-id df-00111111PLAYERTABLE --pipeline-definition file://PLAYER.json
</code><br />
<code>
aws datapipeline put-pipeline-definition --pipeline-id df-00111111GAMETABLE --pipeline-definition file://GAME.json
</code><br />
<code>
aws datapipeline put-pipeline-definition --pipeline-id df-00111111PROBOWLTABLE --pipeline-definition file://PROBOWL.json
</code><br />


If pipeline validates successfully, the validationErrors field is empty. We should review any warnings.

To activate pipeline, used the following activate-pipeline command.

<code>aws datapipeline activate-pipeline --pipeline-id df-00111111PBPTABLE</code><br />
<code>aws datapipeline activate-pipeline --pipeline-id df-00111111PLAYERTABLE</code><br />
<code>aws datapipeline activate-pipeline --pipeline-id df-00111111GAMETABLE</code><br />
<code>aws datapipeline activate-pipeline --pipeline-id df-00111111PROBOWLTABLE</code><br />


Verify that your pipeline appears in the pipeline list using the following list-pipelines command.

<code>aws datapipeline list-pipelines</code><br />
