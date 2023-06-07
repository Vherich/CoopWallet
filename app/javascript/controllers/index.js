// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ExpenseController from "./expense_controller"
application.register("expense", ExpenseController)

import ChartController from "./chart_controller"
application.register("chart", ChartController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import Chart from 'stimulus-chartjs'

const application = application.start()
application.register('chart', Chart)
