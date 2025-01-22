import Foundation

enum ProcessResultsOption {
    case quantity, averageQueueLength, failureProbability, averageLoadDevice, averageWorkingDevice, averageTasksInWork, averageTimeBetweenTaskCompletions
}

enum CreateResultsOption {
    case quantity
}

enum ModelResultsOption {
    case averageTasksInModel, averageTimeBetweenTaskCompletions, averageTimeTasksSpendsInModel, failureProbability, relatedCount
}
