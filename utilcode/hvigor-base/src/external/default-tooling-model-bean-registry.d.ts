import { ToolingModelBeanRegistry } from "./tooling-model-bean-registry";
import { ToolingModelBean } from "./tooling-model-bean";
/**
 * 默认的Hvigor的数据扩展模型的注册器
 *
 * @since 2022/2/19
 */
declare class DefaultToolingModelBeanRegistry implements ToolingModelBeanRegistry {
    private _log;
    private readonly _modelMap;
    constructor();
    registry(modelBean: ToolingModelBean): void;
    getModelMap(): Map<string, ToolingModelBean>;
}
export declare const defaultModelRegistry: DefaultToolingModelBeanRegistry;
export {};
