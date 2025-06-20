/* eslint-disable @typescript-eslint/no-unused-vars */
import { WebPlugin } from '@capacitor/core';
export class CapacitorHealthkitWeb extends WebPlugin {
    async requestAuthorization(_authOptions) {
        throw this.unimplemented('Not implemented on web.');
    }
    async queryHKitSampleType(_queryOptions) {
        throw this.unimplemented('Not implemented on web.');
    }
    async isAvailable() {
        throw this.unimplemented('Not implemented on web.');
    }
    async multipleQueryHKitSampleType(_queryOptions) {
        throw this.unimplemented('Not implemented on web.');
    }
    async isEditionAuthorized(_queryOptions) {
        throw this.unimplemented('Not implemented on web.');
    }
    async multipleIsEditionAuthorized() {
        throw this.unimplemented('Not implemented on web.');
    }
    async saveWeight(_weightData) {
        throw this.unimplemented('Not implemented on web.');
    }
    async saveHeight(_heightData) {
        throw this.unimplemented('Not implemented on web.');
    }
    async saveActiveEnergyBurned(_energyData) {
        throw this.unimplemented('Not implemented on web.');
    }
}
//# sourceMappingURL=web.js.map