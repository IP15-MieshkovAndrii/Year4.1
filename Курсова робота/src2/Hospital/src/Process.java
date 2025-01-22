import java.util.ArrayList;
import java.util.List;

public class Process extends Element {
    
    private QueueP queue = new QueueP();

    public Process(String nameOfElement, List<Double> delays, List<String> distributions, int numberOfDevices) {
        super(nameOfElement, delays, distributions, numberOfDevices);
    }

    @Override
    public void inAct(Patient patient) {
        String name = super.getName();
        int type = patient.getType();
        if(name == "Registration in the laboratory") {
            entryTimes.add(super.getTcurr());
        }
        for (Device device : super.getDevices()) {
            device.setTcurr(super.getTcurr());
            if (device.getState() == 0) {
                int delayNumber = device.getDelayNumber();
                if(delayNumber == 3){
                    device.inAct(patient, type-1);
                } else {
                    device.inAct(patient, 0);
                }
                super.updateTnext();
                return;
            }
        }

        queue.add(patient);
        super.maxQueue = queue.length()>super.maxQueue ? queue.length() : super.maxQueue;
    }

    @Override
    public void outAct( ) {
        List<Patient> outTasks = new ArrayList<>();
        for (Device device : super.getDevices()) {
            device.setTcurr(super.getTcurr());
            if (device.getTNext() == super.getTcurr()) {
                Patient task = device.outAct();
                if(task instanceof Patient && task != null) {
                    outTasks.add(task);
                } 
            }
        }
        if (outTasks.size() > 0){
            for (Patient task : outTasks) {
                super.outAct();
                Transfer transfer = super.getTransfer();
                if(transfer != null){
                    String next = transfer.goNext(this, super.getTcurr(), task);
                    if((next != "blocked") && queue.length() > 0){
                        Patient patient = this.queue.remove();
                        int type = patient.getType();
                        for (Device device : super.getDevices()) {
                            device.setTcurr(super.getTcurr());
                            if (device.getState() == 0) {
                                int delayNumber = device.getDelayNumber();
                                if(delayNumber == 3){
                                    device.inAct(patient, type-1);
                                } else {
                                    device.inAct(patient, 0);
                                }
                                super.updateTnext();
                                return;
                            }
                        }
                    }
                    if(next == null){
                        this.addDuration(task);
                    }
                }
                if(transfer == null){
                    this.addDuration(task);
                }
            }
        }
        for (Device device : super.getDevices()) {
            if (device.getState() == 0) {
                device.setTNext(Double.MAX_VALUE);
            }
        }
        super.updateTnext();
    }

    @Override
    public void doStatistics(double delta){
    }

    public void addDuration(Patient patient) {
        int type = patient.getType();
        int flag = patient.getFlag();
        patient.setExit(super.getTcurr());

        if (type == 1) {
            if(flag == 0) {
                super.type1.add(patient.getDuration());
            } else {
                super.type2.add(patient.getDuration());
            }
        } else if (type == 3) {
            super.type3.add(patient.getDuration());
        }
    }


}
