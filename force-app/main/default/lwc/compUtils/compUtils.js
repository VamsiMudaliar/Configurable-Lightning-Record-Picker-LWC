import { LightningElement } from 'lwc';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';

export default class CompUtils extends LightningElement {}


export function showAsyncErrorMessage(component, error) {
    showMessage(component, {
        title: "Error",
        message: (typeof error === 'string') ? error : ((error) ? ((error.message) ? error.message : ((error.body) ? ((error.body.message) ? error.body.message : JSON.stringify(error)) : JSON.stringify(error))) : "Something went wrong!"),
        messageType: 'error',
        mode: 'dismissible',
    });
}

export function showMessage(component, {
    title,
    message,
    messageType,
    mode
}) {
    component.dispatchEvent(new ShowToastEvent({
        mode,
        title,
        message,
        variant: messageType,
    }));
}