require_relative './config/environment'
run ApplicationController

# Controllers V1
use Api::V1::CarsController
use Api::V1::UsersController

# Authentication Controller
use Api::Auth::AuthController
