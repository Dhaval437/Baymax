export function requestRobotState(headers) {
  const flag = name => headers[name] === '1' ? true : headers[name] === '0' ? false : null;
  return { motorsEnabled: flag('x-baymax-motion'), controllerAvailable: flag('x-baymax-pca'),
    conversation: flag('x-baymax-conversation') };
}
export function spokenRobotStatus(state) {
  const motors = state.controllerAvailable === false ? 'The motor controller is not responding.' :
    state.motorsEnabled === true ? 'Motor control is enabled.' :
    state.motorsEnabled === false ? 'Motor control is disabled.' : 'Motor status is unavailable.';
  const conversation = state.conversation === true ? 'Conversation is active.' :
    state.conversation === false ? 'I am waiting for a wake word.' : 'Conversation state is unavailable.';
  return `Wi-Fi is connected and this request reached the server. I recognized your microphone command. ${motors} ${conversation}`;
}
