resource "aws_cloudwatch_event_rule" "schedule" {
    name                = "aws_workflow_trigger_schedule"
    description         = "Schedule for Lambda Function"
    schedule_expression = "cron(0/5 17-21 * * ? *)"  # Example: Trigger every day at 12:00 PM UTC
}


resource "aws_cloudwatch_event_target" "schedule_lambda" {
    rule = aws_cloudwatch_event_rule.schedule.name
    target_id = "processing_lambda"
    arn = "arn:aws:lambda:us-east-1:704854337545:function:aws_trigger_afterhours_function"
}


resource "aws_lambda_permission" "allow_events_bridge_to_run_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "aws_trigger_afterhours_function"
    principal = "events.amazonaws.com"
}