workspace "Exercise 2" "Level 1 C4 Model" {

    model {
        user = person "User" {
            tags "user"
        }
        webApp = softwareSystem "Web Application" "Instant Messaging Platform" {
           tags "webapp"
        }
        cogusrPool = softwareSystem "Cognito User Pool" {
            tags "cognito user pool"
        }
        cogidtPool = softwareSystem "Cognito Identity Pool" {
            tags "cognito identity pool"
        }
        lamda = softwareSystem "Lamda"
        chime = softwareSystem "Chime Messaging"
        properties {
            "structurizr.groupSeparator" "/"
        }
        group "Computing Components" {
                group "EC2 Load Balancer" {
                    ec2 = softwareSystem "EC2 Load Balancer"
                }
                group "Fargate" {
                    fargate = softwareSystem "Fargate"
                }
                group "ECS" {
                    ecs = softwareSystem "ECS"
                }
                group "ECR" {
                    ecr = softwareSystem "ECR"
                }
        }
        user -> webApp "Uses"
        webApp -> cogusrPool "Authentication (Access Token Exchange)"
        cogusrPool -> lamda "Sign up (Confirmation Trigger)"
        lamda -> chime "Created app instance user"
        chime -> webApp "Websocket Connection"
        webApp -> chime "Websocket Connection"
        webApp -> cogidtPool "Exchange Access Token"
        cogidtPool -> webApp "Exchange Access Token"
        ec2 -> fargate "Distributes traffic between multiple intances"
        ecs -> fargate "Orchestrates instance"
        ecs -> ecr "Puts image"
        fargate -> webApp "Hosts"
    }

    views {
    
        systemLandscape {
            include *
            autoLayout lr
        }
        styles {
            element "webapp" {
                shape webBrowser
            }
            element "user" {
                shape Person
            }
            element "cognito user pool" {
                shape Cylinder
            }
            element "cognito identity pool" {
                shape Cylinder
            }
        }
    theme default
}
