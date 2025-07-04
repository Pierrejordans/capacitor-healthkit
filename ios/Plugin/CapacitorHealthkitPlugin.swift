import Foundation
import Capacitor
import HealthKit

var healthStore = HKHealthStore()

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorHealthkitPlugin)
public class CapacitorHealthkitPlugin: CAPPlugin {

    enum HKSampleError: Error {
        case sleepRequestFailed
        case workoutRequestFailed
        case quantityRequestFailed
        case sampleTypeFailed
        case deniedDataAccessFailed

        var outputMessage: String {
            switch self {
            case .sleepRequestFailed:
                return "sleepRequestFailed"
            case .workoutRequestFailed:
                return "workoutRequestFailed"
            case .quantityRequestFailed:
                return "quantityRequestFailed"
            case .sampleTypeFailed:
                return "sampleTypeFailed"
            case .deniedDataAccessFailed:
                return "deniedDataAccessFailed"
            }
        }
    }

    func getSampleType(sampleName: String) -> HKSampleType? {
        switch sampleName {
        case "stepCount":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        case "flightsClimbed":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)!
        case "appleExerciseTime":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        case "activeEnergyBurned":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        case "basalEnergyBurned":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)!
        case "distanceWalkingRunning":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        case "distanceCycling":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!
        case "bloodGlucose":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!
        case "sleepAnalysis":
            return HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        case "workoutType":
            return HKWorkoutType.workoutType()
        case "weight":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        case "height":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        case "heartRate":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        case "restingHeartRate":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!
        case "respiratoryRate":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        case "bodyFat":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!
        case "oxygenSaturation":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!
        case "basalBodyTemperature":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalBodyTemperature)!
        case "bodyTemperature":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!
        case "bloodPressureSystolic":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
        case "bloodPressureDiastolic":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!
        default:
            return nil
        }
    }

    func getTypes(items: [String]) -> Set<HKSampleType> {
        var types: Set<HKSampleType> = []
        for item in items {
            switch item {
            case "steps":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            case "stairs":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)!)
            case "duration":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!)
            case "activity":
                types.insert(HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!)
                types.insert(HKWorkoutType.workoutType())
            case "calories":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!)
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)!)
            case "distance":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!)
            case "bloodGlucose":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!)
            case "weight":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!)
            case "height":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)
            case "heartRate":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!)
            case "restingHeartRate":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!)
            case "respiratoryRate":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!)
            case "bodyFat":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!)
            case "oxygenSaturation":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!)
            case "basalBodyTemperature":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalBodyTemperature)!)
            case "bodyTemperature":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!)
            case "bloodPressureSystolic":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!)
            case "bloodPressureDiastolic":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!)
            default:
                print("no match in case: " + item)
            }
        }
        return types
    }
    
    func returnWorkoutActivityTypeValueDictionnary(activityType: HKWorkoutActivityType) -> String {
         // from https://github.com/georgegreenoflondon/HKWorkoutActivityType-Descriptions/blob/master/HKWorkoutActivityType%2BDescriptions.swift
         switch activityType {
         case HKWorkoutActivityType.americanFootball:
             return "American Football"
         case HKWorkoutActivityType.archery:
             return "Archery"
         case HKWorkoutActivityType.australianFootball:
             return "Australian Football"
         case HKWorkoutActivityType.badminton:
             return "Badminton"
         case HKWorkoutActivityType.baseball:
             return "Baseball"
         case HKWorkoutActivityType.basketball:
             return "Basketball"
         case HKWorkoutActivityType.bowling:
             return "Bowling"
         case HKWorkoutActivityType.boxing:
             return "Boxing"
         case HKWorkoutActivityType.climbing:
             return "Climbing"
         case HKWorkoutActivityType.crossTraining:
             return "Cross Training"
         case HKWorkoutActivityType.curling:
             return "Curling"
         case HKWorkoutActivityType.cycling:
             return "Cycling"
         case HKWorkoutActivityType.dance:
             return "Dance"
         case HKWorkoutActivityType.danceInspiredTraining:
             return "Dance Inspired Training"
         case HKWorkoutActivityType.elliptical:
             return "Elliptical"
         case HKWorkoutActivityType.equestrianSports:
             return "Equestrian Sports"
         case HKWorkoutActivityType.fencing:
             return "Fencing"
         case HKWorkoutActivityType.fishing:
             return "Fishing"
         case HKWorkoutActivityType.functionalStrengthTraining:
             return "Functional Strength Training"
         case HKWorkoutActivityType.golf:
             return "Golf"
         case HKWorkoutActivityType.gymnastics:
             return "Gymnastics"
         case HKWorkoutActivityType.handball:
             return "Handball"
         case HKWorkoutActivityType.hiking:
             return "Hiking"
         case HKWorkoutActivityType.hockey:
             return "Hockey"
         case HKWorkoutActivityType.hunting:
             return "Hunting"
         case HKWorkoutActivityType.lacrosse:
             return "Lacrosse"
         case HKWorkoutActivityType.martialArts:
             return "Martial Arts"
         case HKWorkoutActivityType.mindAndBody:
             return "Mind and Body"
         case HKWorkoutActivityType.mixedMetabolicCardioTraining:
             return "Mixed Metabolic Cardio Training"
         case HKWorkoutActivityType.paddleSports:
             return "Paddle Sports"
         case HKWorkoutActivityType.play:
             return "Play"
         case HKWorkoutActivityType.preparationAndRecovery:
             return "Preparation and Recovery"
         case HKWorkoutActivityType.racquetball:
             return "Racquetball"
         case HKWorkoutActivityType.rowing:
             return "Rowing"
         case HKWorkoutActivityType.rugby:
             return "Rugby"
         case HKWorkoutActivityType.running:
             return "Running"
         case HKWorkoutActivityType.sailing:
             return "Sailing"
         case HKWorkoutActivityType.skatingSports:
             return "Skating Sports"
         case HKWorkoutActivityType.snowSports:
             return "Snow Sports"
         case HKWorkoutActivityType.soccer:
             return "Soccer"
         case HKWorkoutActivityType.softball:
             return "Softball"
         case HKWorkoutActivityType.squash:
             return "Squash"
         case HKWorkoutActivityType.stairClimbing:
             return "Stair Climbing"
         case HKWorkoutActivityType.surfingSports:
             return "Surfing Sports"
         case HKWorkoutActivityType.swimming:
             return "Swimming"
         case HKWorkoutActivityType.tableTennis:
             return "Table Tennis"
         case HKWorkoutActivityType.tennis:
             return "Tennis"
         case HKWorkoutActivityType.trackAndField:
             return "Track and Field"
         case HKWorkoutActivityType.traditionalStrengthTraining:
             return "Traditional Strength Training"
         case HKWorkoutActivityType.volleyball:
             return "Volleyball"
         case HKWorkoutActivityType.walking:
             return "Walking"
         case HKWorkoutActivityType.waterFitness:
             return "Water Fitness"
         case HKWorkoutActivityType.waterPolo:
             return "Water Polo"
         case HKWorkoutActivityType.waterSports:
             return "Water Sports"
         case HKWorkoutActivityType.wrestling:
             return "Wrestling"
         case HKWorkoutActivityType.yoga:
             return "Yoga"
         // iOS 10
         case HKWorkoutActivityType.barre:
             return "Barre"
         case HKWorkoutActivityType.coreTraining:
             return "Core Training"
         case HKWorkoutActivityType.crossCountrySkiing:
             return "Cross Country Skiing"
         case HKWorkoutActivityType.downhillSkiing:
             return "Downhill Skiing"
         case HKWorkoutActivityType.flexibility:
             return "Flexibility"
         case HKWorkoutActivityType.highIntensityIntervalTraining:
             return "High Intensity Interval Training"
         case HKWorkoutActivityType.jumpRope:
             return "Jump Rope"
         case HKWorkoutActivityType.kickboxing:
             return "Kickboxing"
         case HKWorkoutActivityType.pilates:
             return "Pilates"
         case HKWorkoutActivityType.snowboarding:
             return "Snowboarding"
         case HKWorkoutActivityType.stairs:
             return "Stairs"
         case HKWorkoutActivityType.stepTraining:
             return "Step Training"
         case HKWorkoutActivityType.wheelchairWalkPace:
             return "Wheelchair Walk Pace"
         case HKWorkoutActivityType.wheelchairRunPace:
             return "Wheelchair Run Pace"
         // iOS 11
         case HKWorkoutActivityType.taiChi:
             return "Tai Chi"
         case HKWorkoutActivityType.mixedCardio:
             return "Mixed Cardio"
         case HKWorkoutActivityType.handCycling:
             return "Hand Cycling"
         // iOS 13
         case HKWorkoutActivityType.discSports:
             return "Disc Sports"
         case HKWorkoutActivityType.fitnessGaming:
             return "Fitness Gaming"
         // Catch-all
         default:
             return "Other"
         }
     }
    
    func getTimeZoneString(sample: HKSample? = nil, shouldReturnDefaultTimeZoneInExceptions _: Bool = true) -> String {
        var timeZone: TimeZone?
        if let metaDataTimeZoneValue = sample?.metadata?[HKMetadataKeyTimeZone] as? String {
            timeZone = TimeZone(identifier: metaDataTimeZoneValue)
        }
        if timeZone == nil {
            timeZone = TimeZone.current
        }
        let seconds: Int = timeZone?.secondsFromGMT() ?? 0
        let hours = seconds / 3600
        let minutes = abs(seconds / 60) % 60
        let timeZoneString = String(format: "%+.2d:%.2d", hours, minutes)
        return timeZoneString
    }

    func generateOutput(sampleName: String, results: [HKSample]?) -> [[String: Any]]? {
        var output: [[String: Any]] = []
        if results == nil {
            return output
        }
        for result in results! {
            if sampleName == "sleepAnalysis" {
                guard let sample = result as? HKCategorySample else {
                    return nil
                }
                let sleepSD = sample.startDate as NSDate
                let sleepED = sample.endDate as NSDate
                let sleepInterval = sleepED.timeIntervalSince(sleepSD as Date)
                let sleepHoursBetweenDates = sleepInterval / 3600
                let sleepState = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                let constructedSample: [String: Any] = [
                    "uuid": sample.uuid.uuidString,
                    "timeZone": getTimeZoneString(sample: sample) as String,
                    "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                    "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                    "duration": sleepHoursBetweenDates,
                    "sleepState": sleepState,
                    "source": sample.sourceRevision.source.name,
                    "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                    "device": getDeviceInformation(device: sample.device),
                ]
                output.append(constructedSample)
            } else if sampleName == "workoutType" {
                guard let sample = result as? HKWorkout else {
                    return nil
                }

                var TEBData: Double? = -1
                var TDData: Double? = -1
                var TFCData: Double? = -1
                var TSSCData: Double? = -1

                var unitTEB: HKUnit?
                if (sample.totalEnergyBurned) != nil {
                    if (sample.totalEnergyBurned?.is(compatibleWith: HKUnit.kilocalorie()))! {
                        unitTEB = HKUnit.kilocalorie()
                    }
                    guard unitTEB != nil else { return nil }
                    TEBData = sample.totalEnergyBurned?.doubleValue(for: unitTEB!)
                }

                var unitTD: HKUnit?
                if (sample.totalDistance) != nil {
                    if (sample.totalDistance?.is(compatibleWith: HKUnit.meter()))! {
                        unitTD = HKUnit.meter()
                    }
                    guard unitTD != nil else { return nil }
                    TDData = sample.totalDistance?.doubleValue(for: unitTD!)
                }

                var unitTFC: HKUnit?
                if (sample.totalFlightsClimbed) != nil {
                    if (sample.totalFlightsClimbed?.is(compatibleWith: HKUnit.count()))! {
                        unitTFC = HKUnit.count()
                    }
                    guard unitTFC != nil else { return nil }
                    TFCData = sample.totalFlightsClimbed?.doubleValue(for: unitTFC!)
                }

                var unitTSSC: HKUnit?
                if (sample.totalSwimmingStrokeCount) != nil {
                    if (sample.totalSwimmingStrokeCount?.is(compatibleWith: HKUnit.count()))! {
                        unitTSSC = HKUnit.count()
                    }
                    guard unitTSSC != nil else { return nil }
                    TSSCData = sample.totalSwimmingStrokeCount?.doubleValue(for: unitTSSC!)
                }

                let workoutSD = sample.startDate as NSDate
                let workoutED = sample.endDate as NSDate
                let workoutInterval = workoutED.timeIntervalSince(workoutSD as Date)
                let workoutHoursBetweenDates = workoutInterval / 3600

                output.append([
                    "uuid": sample.uuid.uuidString,
                    "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                    "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                    "duration": workoutHoursBetweenDates,
                    "source": sample.sourceRevision.source.name,
                    "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                    "device": getDeviceInformation(device: sample.device),
                    "workoutActivityId": sample.workoutActivityType.rawValue,
                    "workoutActivityName": returnWorkoutActivityTypeValueDictionnary(activityType: sample.workoutActivityType),
                    "totalEnergyBurned": TEBData!, // kilocalorie
                    "totalDistance": TDData!, // meter
                    "totalFlightsClimbed": TFCData!, // count
                    "totalSwimmingStrokeCount": TSSCData!, // count
                ])
            } else {
                guard let sample = result as? HKQuantitySample else {
                    return nil
                }
                var unit: HKUnit?
                var unitName: String?

                if sampleName == "heartRate" {
                    unit = HKUnit(from: "count/min")
                    unitName = "BPM"
                } else if sampleName == "restingHeartRate" {
                    unit = HKUnit(from: "count/min")
                    unitName = "BPM"
                } else if sampleName == "weight" {
                    unit = HKUnit.gramUnit(with: .kilo)
                    unitName = "kilogram"
                } else if sampleName == "respiratoryRate" {
                    unit = HKUnit(from: "count/min")
                    unitName = "BrPM"
                } else if sampleName == "bodyFat" {
                    unit = HKUnit.percent()
                    unitName = "percent"
                } else if sampleName == "oxygenSaturation" {
                    unit = HKUnit.percent()
                    unitName = "percent"
                } else if sample.quantityType.is(compatibleWith: HKUnit.meter()) {
                    unit = HKUnit.meter()
                    unitName = "meter"
                } else if sample.quantityType.is(compatibleWith: HKUnit.count()) {
                    unit = HKUnit.count()
                    unitName = "count"
                } else if sample.quantityType.is(compatibleWith: HKUnit.minute()) {
                    unit = HKUnit.minute()
                    unitName = "minute"
                } else if sample.quantityType.is(compatibleWith: HKUnit.kilocalorie()) {
                    unit = HKUnit.kilocalorie()
                    unitName = "kilocalorie"
                } else if sample.quantityType.is(compatibleWith: HKUnit.moleUnit(withMolarMass: HKUnitMolarMassBloodGlucose).unitDivided(by: HKUnit.literUnit(with: .kilo))) {
                    unit = HKUnit.moleUnit(withMolarMass: HKUnitMolarMassBloodGlucose).unitDivided(by: HKUnit.literUnit(with: .kilo))
                    unitName = "mmol/L"
                } else if sample.quantityType.is(compatibleWith: HKUnit.degreeCelsius()) {
                    unit = HKUnit.degreeCelsius()
                    unitName = "celsius"
                } else if sample.quantityType.is(compatibleWith: HKUnit.degreeFahrenheit()) {
                    unit = HKUnit.degreeFahrenheit()
                    unitName = "fahrenheit"
                } else if sample.quantityType.is(compatibleWith: HKUnit.kelvin()) {
                    unit = HKUnit.kelvin()
                    unitName = "kelvin"
                } else if sample.quantityType.is(compatibleWith: HKUnit.millimeterOfMercury()) {
                    unit = HKUnit.millimeterOfMercury()
                    unitName = "mmHg"
                } else {
                    print("Error: unknown unit type")
                }

                var value: Double 
                let quantitySD: NSDate
                let quantityED: NSDate
                quantitySD = sample.startDate as NSDate
                quantityED = sample.endDate as NSDate
                let quantityInterval = quantityED.timeIntervalSince(quantitySD as Date)
                let quantitySecondsInAnHour: Double = 3600
                let quantityHoursBetweenDates = quantityInterval / quantitySecondsInAnHour

                output.append([
                    "uuid": sample.uuid.uuidString,
                    "value": sample.quantity.doubleValue(for: unit!),
                    "unitName": unitName!,
                    "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                    "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                    "duration": quantityHoursBetweenDates,
                    "source": sample.sourceRevision.source.name,
                    "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                    "device": getDeviceInformation(device: sample.device),
                ])
            }
        }
        return output
    }

    func getDeviceInformation(device: HKDevice?) -> [String: String?]? {
        if (device == nil) {
            return nil;
        }
        
        let deviceInformation: [String: String?] = [
            "name": device?.name,
            "model": device?.model,
            "manufacturer": device?.manufacturer,
            "hardwareVersion": device?.hardwareVersion,
            "softwareVersion": device?.softwareVersion,
        ];
                
        return deviceInformation;
    }

    func getDateFromString(inputDate: String) -> Date{
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: inputDate)!
    }

    
    @objc func requestAuthorization(_ call: CAPPluginCall) {
        if !HKHealthStore.isHealthDataAvailable() {
            return call.reject("Health data not available")
        }
        guard let _all = call.options["all"] as? [String] else {
            return call.reject("Must provide all")
        }
        guard let _read = call.options["read"] as? [String] else {
            return call.reject("Must provide read")
        }
        guard let _write = call.options["write"] as? [String] else {
            return call.reject("Must provide write")
        }

        let writeTypes: Set<HKSampleType> = getTypes(items: _write).union(getTypes(items: _all))
        let readTypes: Set<HKSampleType> = getTypes(items: _read).union(getTypes(items: _all))

        healthStore.requestAuthorization(toShare: writeTypes, read: readTypes) { success, _ in
            if !success {
                call.reject("Could not get permission")
                return
            }
            call.resolve()
        }
    }
    @objc func queryHKitSampleType(_ call: CAPPluginCall) {
        guard let _sampleName = call.options["sampleName"] as? String else {
            return call.reject("Must provide sampleName")
        }
        guard let startDateString = call.options["startDate"] as? String else {
            return call.reject("Must provide startDate")
        }
        guard let endDateString = call.options["endDate"] as? String else {
            return call.reject("Must provide endDate")
        }

        let _startDate = getDateFromString(inputDate: startDateString)
        let _endDate = getDateFromString(inputDate: endDateString)
        guard let _limit = call.options["limit"] as? Int else {
            return call.reject("Must provide limit")
        }

        let limit: Int = (_limit == 0) ? HKObjectQueryNoLimit : _limit

        let predicate = HKQuery.predicateForSamples(withStart: _startDate, end: _endDate, options: HKQueryOptions.strictStartDate)

        guard let sampleType: HKSampleType = getSampleType(sampleName: _sampleName) else {
            return call.reject("Error in sample name")
        }

        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: nil) {
            _, results, _ in
            guard let output: [[String: Any]] = self.generateOutput(sampleName: _sampleName, results: results) else {
                return call.reject("Error happened while generating outputs")
            }
            call.resolve([
                "countReturn": output.count,
                "resultData": output,
            ])
        }
        healthStore.execute(query)
    }
    
    @objc func isAvailable(_ call: CAPPluginCall) {
        if HKHealthStore.isHealthDataAvailable() {
            return call.resolve()
        } else {
            return call.reject("Health data not available")
        }
    }

    @objc func isEditionAuthorized(_ call: CAPPluginCall) {
        guard let sampleName = call.options["sampleName"] as? String else {
            return call.reject("Must provide sampleName")
        }

        let sampleType: HKSampleType? = getSampleType(sampleName: sampleName)
        if sampleType == nil {
            return call.reject("Cannot match sample name")
        }

        if healthStore.authorizationStatus(for: sampleType!) == .sharingAuthorized {
            return call.resolve()
        } else {
            return call.reject("Permission Denied to Access data")
        }
    }

    @objc func multipleIsEditionAuthorized(_ call: CAPPluginCall) {
        guard let sampleNames = call.options["sampleNames"] as? [String] else {
            return call.reject("Must provide sampleNames")
        }

        for sampleName in sampleNames {
            guard let sampleType: HKSampleType = getSampleType(sampleName: sampleName) else {
                return call.reject("Cannot match sample name")
            }
            if healthStore.authorizationStatus(for: sampleType) != .sharingAuthorized {
                return call.reject("Permission Denied to Access data")
            }
        }
        return call.resolve()
    }

    @objc func multipleQueryHKitSampleType(_ call: CAPPluginCall) {
        guard let _sampleNames = call.options["sampleNames"] as? [String] else {
            call.reject("Must provide sampleNames")
            return
        }
        guard let _startDate = call.options["startDate"] as? Date else {
            call.reject("Must provide startDate")
            return
        }
        guard let _endDate = call.options["endDate"] as? Date else {
            call.reject("Must provide endDate")
            return
        }
        guard let _limit = call.options["limit"] as? Int else {
            call.reject("Must provide limit")
            return
        }

        let limit: Int = (_limit == 0) ? HKObjectQueryNoLimit : _limit

        var output: [String: [String: Any]] = [:]

        let dispatchGroup = DispatchGroup()

        for _sampleName in _sampleNames {
            dispatchGroup.enter()

            queryHKitSampleTypeSpecial(sampleName: _sampleName, startDate: _startDate, endDate: _endDate, limit: limit) { result in
                switch result {
                case let .success(sampleOutput):
                    output[_sampleName] = sampleOutput
                case let .failure(error):

                    var errorMessage = ""
                    if let localError = error as? HKSampleError {
                        errorMessage = localError.outputMessage
                    } else {
                        errorMessage = error.localizedDescription
                    }
                    output[_sampleName] = ["errorDescription": errorMessage]
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            print(output.description)
            call.resolve(output)
        }
    }
      
    func queryHKitSampleTypeSpecial(sampleName: String, startDate: Date, endDate: Date, limit: Int, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions.strictStartDate)

        guard let sampleType: HKSampleType = getSampleType(sampleName: sampleName) else {
            return completion(.failure(HKSampleError.sampleTypeFailed))
        }

        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: nil) {
            _, results, _ in
            guard let output: [[String: Any]] = self.generateOutput(sampleName: sampleName, results: results) else {
                return completion(.failure(HKSampleError.sampleTypeFailed))
            }
            completion(.success([
                "countReturn": output.count,
                "resultData": output,
            ]))
        }
        healthStore.execute(query)
    }
    
    // MARK: - Write Methods
    
    @objc func saveWeight(_ call: CAPPluginCall) {
        guard let weightData = call.options["weightData"] as? [String: Any] else {
            return call.reject("Must provide weightData")
        }
        
        guard let value = weightData["value"] as? Double else {
            return call.reject("Must provide value in weightData")
        }
        
        guard let startDateString = weightData["startDate"] as? String else {
            return call.reject("Must provide startDate in weightData")
        }
        
        let startDate = getDateFromString(inputDate: startDateString)
        let endDate = weightData["endDate"] as? String != nil ? getDateFromString(inputDate: weightData["endDate"] as! String) : startDate
        let metadata = weightData["metadata"] as? [String: Any]
        
        // Create weight quantity sample
        let weightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let weightQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: value)
        let weightSample = HKQuantitySample(type: weightType, quantity: weightQuantity, start: startDate, end: endDate, metadata: metadata)
        
        healthStore.save(weightSample) { success, error in
            if success {
                call.resolve([
                    "success": true,
                    "uuid": weightSample.uuid.uuidString
                ])
            } else {
                call.reject("Failed to save weight data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    @objc func saveHeight(_ call: CAPPluginCall) {
        guard let heightData = call.options["heightData"] as? [String: Any] else {
            return call.reject("Must provide heightData")
        }
        
        guard let value = heightData["value"] as? Double else {
            return call.reject("Must provide value in heightData")
        }
        
        guard let startDateString = heightData["startDate"] as? String else {
            return call.reject("Must provide startDate in heightData")
        }
        
        let startDate = getDateFromString(inputDate: startDateString)
        let endDate = heightData["endDate"] as? String != nil ? getDateFromString(inputDate: heightData["endDate"] as! String) : startDate
        let metadata = heightData["metadata"] as? [String: Any]
        
        // Create height quantity sample (convert cm to meters for HealthKit)
        let heightType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let heightQuantity = HKQuantity(unit: HKUnit.meterUnit(with: .centi), doubleValue: value)
        let heightSample = HKQuantitySample(type: heightType, quantity: heightQuantity, start: startDate, end: endDate, metadata: metadata)
        
        healthStore.save(heightSample) { success, error in
            if success {
                call.resolve([
                    "success": true,
                    "uuid": heightSample.uuid.uuidString
                ])
            } else {
                call.reject("Failed to save height data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    @objc func saveActiveEnergyBurned(_ call: CAPPluginCall) {
        guard let energyData = call.options["energyData"] as? [String: Any] else {
            return call.reject("Must provide energyData")
        }
        
        guard let value = energyData["value"] as? Double else {
            return call.reject("Must provide value in energyData")
        }
        
        guard let startDateString = energyData["startDate"] as? String else {
            return call.reject("Must provide startDate in energyData")
        }
        
        guard let endDateString = energyData["endDate"] as? String else {
            return call.reject("Must provide endDate in energyData")
        }
        
        let startDate = getDateFromString(inputDate: startDateString)
        let endDate = getDateFromString(inputDate: endDateString)
        let metadata = energyData["metadata"] as? [String: Any]
        
        // Create active energy burned quantity sample
        let energyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let energyQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: value)
        let energySample = HKQuantitySample(type: energyType, quantity: energyQuantity, start: startDate, end: endDate, metadata: metadata)
        
        healthStore.save(energySample) { success, error in
            if success {
                call.resolve([
                    "success": true,
                    "uuid": energySample.uuid.uuidString
                ])
            } else {
                call.reject("Failed to save energy data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
