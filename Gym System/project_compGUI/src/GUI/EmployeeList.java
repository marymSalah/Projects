/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package GUI;

/**
 *
 * @author noora
 */
public class EmployeeList extends javax.swing.JFrame {

    /**
     * Creates new form Employee2
     */
    public EmployeeList() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPopupMenu1 = new javax.swing.JPopupMenu();
        jLabel6 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        back = new javax.swing.JButton();
        listTM = new javax.swing.JButton();
        updateEmp = new javax.swing.JButton();
        addEmp = new javax.swing.JButton();
        deleteEmp = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jLabel6.setFont(new java.awt.Font("Georgia Pro Cond Semibold", 0, 18)); // NOI18N
        jLabel6.setForeground(new java.awt.Color(255, 255, 255));
        jLabel6.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel6.setText("List Trainers Members");
        getContentPane().add(jLabel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 300, 180, 40));

        jLabel5.setFont(new java.awt.Font("Georgia Pro Cond Semibold", 0, 18)); // NOI18N
        jLabel5.setForeground(new java.awt.Color(255, 255, 255));
        jLabel5.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel5.setText("Delete Employee");
        getContentPane().add(jLabel5, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 240, 180, 40));

        jLabel4.setFont(new java.awt.Font("Georgia Pro Cond Semibold", 0, 18)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel4.setText("Update Employee");
        getContentPane().add(jLabel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 180, 180, 40));

        jLabel3.setFont(new java.awt.Font("Georgia Pro Cond Semibold", 0, 18)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 255, 255));
        jLabel3.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel3.setText("Add new employee");
        getContentPane().add(jLabel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 120, 180, 40));

        jLabel1.setBackground(new java.awt.Color(0, 0, 0));
        jLabel1.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 48)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(255, 255, 255));
        jLabel1.setText("Employees");
        getContentPane().add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(300, 40, -1, -1));

        jLabel7.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 18)); // NOI18N
        jLabel7.setForeground(new java.awt.Color(255, 255, 255));
        jLabel7.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel7.setText("Back");
        getContentPane().add(jLabel7, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 370, 80, 20));

        back.setBackground(new java.awt.Color(204, 153, 255));
        back.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 18)); // NOI18N
        back.setForeground(new java.awt.Color(255, 255, 255));
        back.setIcon(new javax.swing.ImageIcon(getClass().getResource("/GUI/button.png"))); // NOI18N
        back.setText("Member");
        back.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                backActionPerformed(evt);
            }
        });
        getContentPane().add(back, new org.netbeans.lib.awtextra.AbsoluteConstraints(390, 370, 80, 20));

        listTM.setBackground(new java.awt.Color(204, 153, 255));
        listTM.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 24)); // NOI18N
        listTM.setForeground(new java.awt.Color(255, 255, 255));
        listTM.setIcon(new javax.swing.ImageIcon(getClass().getResource("/GUI/button.png"))); // NOI18N
        listTM.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                listTMActionPerformed(evt);
            }
        });
        getContentPane().add(listTM, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 300, 180, 40));
        deleteEmp.setOpaque(false);
        deleteEmp.setContentAreaFilled(false);
        deleteEmp.setBorderPainted(false);

        updateEmp.setBackground(new java.awt.Color(204, 153, 255));
        updateEmp.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 24)); // NOI18N
        updateEmp.setForeground(new java.awt.Color(255, 255, 255));
        updateEmp.setIcon(new javax.swing.ImageIcon(getClass().getResource("/GUI/button.png"))); // NOI18N
        updateEmp.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                updateEmpActionPerformed(evt);
            }
        });
        getContentPane().add(updateEmp, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 180, 180, 40));
        deleteEmp.setOpaque(false);
        deleteEmp.setContentAreaFilled(false);
        deleteEmp.setBorderPainted(false);

        addEmp.setBackground(new java.awt.Color(204, 153, 255));
        addEmp.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 24)); // NOI18N
        addEmp.setForeground(new java.awt.Color(255, 255, 255));
        addEmp.setIcon(new javax.swing.ImageIcon(getClass().getResource("/GUI/button.png"))); // NOI18N
        addEmp.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                addEmpActionPerformed(evt);
            }
        });
        getContentPane().add(addEmp, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 120, 180, 40));
        deleteEmp.setOpaque(false);
        deleteEmp.setContentAreaFilled(false);
        deleteEmp.setBorderPainted(false);

        deleteEmp.setBackground(new java.awt.Color(204, 153, 255));
        deleteEmp.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 24)); // NOI18N
        deleteEmp.setForeground(new java.awt.Color(255, 255, 255));
        deleteEmp.setIcon(new javax.swing.ImageIcon(getClass().getResource("/GUI/button.png"))); // NOI18N
        deleteEmp.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                deleteEmpActionPerformed(evt);
            }
        });
        getContentPane().add(deleteEmp, new org.netbeans.lib.awtextra.AbsoluteConstraints(280, 240, 180, 40));
        deleteEmp.setOpaque(false);
        deleteEmp.setContentAreaFilled(false);
        deleteEmp.setBorderPainted(false);

        jLabel2.setFont(new java.awt.Font("Gloucester MT Extra Condensed", 0, 12)); // NOI18N
        jLabel2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/GUI/members.png"))); // NOI18N
        getContentPane().add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 480, 470));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void deleteEmpActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_deleteEmpActionPerformed
        // TODO add your handling code here:
        new deleteemp1().setVisible(true);
        this.setVisible(false);
    }//GEN-LAST:event_deleteEmpActionPerformed

    private void addEmpActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addEmpActionPerformed
        // TODO add your handling code here:
            new addemp().setVisible(true);
        this.setVisible(false);
    }//GEN-LAST:event_addEmpActionPerformed

    private void updateEmpActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_updateEmpActionPerformed
        // TODO add your handling code here:
        new updateemployeeID().setVisible(true);
        this.setVisible(false);
    }//GEN-LAST:event_updateEmpActionPerformed

    private void listTMActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_listTMActionPerformed
        // TODO add your handling code here:
        new listTM().setVisible(true);
        this.setVisible(false);
    }//GEN-LAST:event_listTMActionPerformed

    private void backActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_backActionPerformed
        // TODO add your handling code here:
        this.setVisible(false);
        new mainmenu2().setVisible(true);
    }//GEN-LAST:event_backActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(EmployeeList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(EmployeeList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(EmployeeList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(EmployeeList.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new EmployeeList().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton addEmp;
    private javax.swing.JButton back;
    private javax.swing.JButton deleteEmp;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JPopupMenu jPopupMenu1;
    private javax.swing.JButton listTM;
    private javax.swing.JButton updateEmp;
    // End of variables declaration//GEN-END:variables
}
