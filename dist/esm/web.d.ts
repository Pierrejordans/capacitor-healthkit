import { WebPlugin } from '@capacitor/core';
import type { EditionQuery, AuthorizationQueryOptions, CapacitorHealthkitPlugin, MultipleQueryOptions, SingleQueryOptions, WeightData, HeightData, EnergyData, SaveResult } from './definitions';
export declare class CapacitorHealthkitWeb extends WebPlugin implements CapacitorHealthkitPlugin {
    requestAuthorization(_authOptions: AuthorizationQueryOptions): Promise<void>;
    queryHKitSampleType(_queryOptions: SingleQueryOptions): Promise<any>;
    isAvailable(): Promise<void>;
    multipleQueryHKitSampleType(_queryOptions: MultipleQueryOptions): Promise<any>;
    isEditionAuthorized(_queryOptions: EditionQuery): Promise<void>;
    multipleIsEditionAuthorized(): Promise<void>;
    saveWeight(_weightData: {
        weightData: WeightData;
    }): Promise<SaveResult>;
    saveHeight(_heightData: {
        heightData: HeightData;
    }): Promise<SaveResult>;
    saveActiveEnergyBurned(_energyData: {
        energyData: EnergyData;
    }): Promise<SaveResult>;
}
